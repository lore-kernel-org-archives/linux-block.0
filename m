Return-Path: <scott.bauer@intel.com>
Date: Wed, 15 Feb 2017 11:15:45 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Rafael Antognolli <rafael.antognolli@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] block/sed: Check received header lengths
Message-ID: <20170215181542.GB3571@sbauer-Z170X-UD5>
References: <1487187535-10503-1-git-send-email-jonathan.derrick@intel.com>
 <1487187535-10503-3-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487187535-10503-3-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 15, 2017 at 12:38:53PM -0700, Jon Derrick wrote:
> Add a buffer size check against discovery and response header lengths
> before we loop over their buffers.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  block/sed-opal.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index d6dd604..addf89e 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -340,10 +340,17 @@ static int opal_discovery0_end(struct opal_dev *dev)
>  	const struct d0_header *hdr = (struct d0_header *)dev->resp;
>  	const u8 *epos = dev->resp, *cpos = dev->resp;
>  	u16 comid = 0;
> +	u32 hlen = be32_to_cpu(hdr->length);
>  
> -	print_buffer(dev->resp, be32_to_cpu(hdr->length));
> +	print_buffer(dev->resp, hlen);
>  
> -	epos += be32_to_cpu(hdr->length); /* end of buffer */
> +	if (hlen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
> +		pr_warn("Discovery length overflows buffer (%zu+%u)/%u\n",
> +			sizeof(*hdr), hlen, IO_BUFFER_LENGTH);
> +		return -EFAULT;
> +	}
> +
> +	epos += hlen; /* end of buffer */
>  	cpos += sizeof(*hdr); /* current position on buffer */
>  
>  	while (cpos < epos && supported) {
> @@ -713,6 +720,7 @@ static int response_parse(const u8 *buf, size_t length,
>  	int total;
>  	ssize_t token_length;
>  	const u8 *pos;
> +	u32 clen, plen, slen;
>  
>  	if (!buf)
>  		return -EFAULT;
> @@ -724,17 +732,16 @@ static int response_parse(const u8 *buf, size_t length,
>  	pos = buf;
>  	pos += sizeof(*hdr);
>  
> -	pr_debug("Response size: cp: %d, pkt: %d, subpkt: %d\n",
> -		 be32_to_cpu(hdr->cp.length),
> -		 be32_to_cpu(hdr->pkt.length),
> -		 be32_to_cpu(hdr->subpkt.length));
> -
> -	if (hdr->cp.length == 0 || hdr->pkt.length == 0 ||
> -	    hdr->subpkt.length == 0) {
> -		pr_err("Bad header length. cp: %d, pkt: %d, subpkt: %d\n",
> -		       be32_to_cpu(hdr->cp.length),
> -		       be32_to_cpu(hdr->pkt.length),
> -		       be32_to_cpu(hdr->subpkt.length));
> +	clen = be32_to_cpu(hdr->cp.length);
> +	plen = be32_to_cpu(hdr->pkt.length);
> +	slen = be32_to_cpu(hdr->subpkt.length);
> +	pr_debug("Response size: cp: %u, pkt: %u, subpkt: %u\n",
> +		 clen, plen, slen);
> +
> +	if (clen == 0 || plen == 0 || slen == 0 ||
> +	    (u64)clen + plen + slen > IO_BUFFER_LENGTH) {

I think we're over calculating here. From my understanding of the spec:
TCG_Storage_Architecture_Core_Spec_v2.01_r1.00.pdf
3.2.3
  ComPackets, Packets & Subpackets

The Comp packet size should the size of the packet, and the subpackets.
The "packet" should be the size of all the subpackets.
And lastly the subpacket should be the size its payload.

if ((u64) slen + sizeof(*hdr) > IO_BUFFER_LENGTH)

Since we never need the com packet length or pkt length (we never use them
anywhere) I think the above check is okay. Let me know if i'm wrong though,
or you have a different understanding of the lengths.
