Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH 4/6] libata: factor out a ata_identify_page_supported
 helper
To: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
References: <20170604124225.27032-1-hch@lst.de>
 <20170604124225.27032-5-hch@lst.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Robert Elliott <elliott@hpe.com>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <950a1c26-c691-9bce-eaa4-873165d7a98b@cogentembedded.com>
Date: Mon, 5 Jun 2017 15:46:42 +0300
MIME-Version: 1.0
In-Reply-To: <20170604124225.27032-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hello!

On 06/04/2017 03:42 PM, Christoph Hellwig wrote:

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ata/libata-core.c | 59 +++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 445e7050637b..f57131115594 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2120,6 +2120,37 @@ static bool ata_log_supported(struct ata_device *dev, u8 log)
>  	return get_unaligned_le16(&ap->sector_buf[log * 2]) ? true : false;
>  }
>
> +static bool ata_identify_page_supported(struct ata_device *dev, u8 page)
> +{
> +	struct ata_port *ap = dev->link->ap;
> +	unsigned int err, i;
> +
> +	if (!ata_log_supported(dev, ATA_LOG_IDENTIFY_DEVICE)) {
> +		ata_dev_warn(dev, "ATA Identify Device Log not supported\n");
> +		return false;
> +	}
> +
> +	/*
> +	 * Read IDENTIFY DEVICE data log, page 0, to figure out if the page is
> +	 * supported.
> +	 */
> +	err = ata_read_log_page(dev, ATA_LOG_IDENTIFY_DEVICE, 0, ap->sector_buf,
> +			1);
> +	if (err) {
> +		ata_dev_info(dev,
> +			     "failed to get Device Identify Log Emask 0x%x\n",
> +			     err);

    Your line continuation style is spomewhat inconsistent: 2 tabs above and 
tabs/spaces here...

[...]

MBR, Sergei
