Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C02AF16;
	Fri, 14 Feb 2025 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499686; cv=none; b=mkNdaaPDPPc0Gw47WloTK8cjUJUYClGlQlu8h5uj4CJndu4vjzd/NefoDOcS/HNjyq5Bcrvm0Skgo0XkCUHHo2QzRvEav9I94xBQ5v5x64oSG26oPpNF5MdS1bsovyvjQQvfgSJq659FwUScKLCpDtCu+RLD4tgNhmpE5Qnl/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499686; c=relaxed/simple;
	bh=IYGI/nWTPXhwIQOYV6ST+oHwwdDS1Ziz7okPrOo0FI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5ROM1s3ATVt/8XPKWlJlffUMAKOUqIoD0bWc3U5sHYCbjtD2i09zZZi31PxYuSWJWT9J1prQr+vczeyBVn/mPiLMMo+NOPNx6uTX3LeiZ3AA8Wo5KB0CbCYOea7VSvvTJzB6+pLIvEjACn3K/8avTBs/Bb22kldV1rqpFHwsWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VSgWsZel; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VSgWsZel"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=Fz06OzUHpQ/u9+meEbjB7yJyMw334z3iTH+lpT2Bpww=; b=VSgWsZelCmMd8HogtQRy+ezRVO
	7+Y39T4KQHxUmlGdBrp9u7472Yy63xKusYg85ySPTbdgmRqGTt4eP/raHR0HyXmrjzwU7D87aMg0C
	SAycBtMHfr1rIW0oUIGthnpKLPb2NBJGry6O0wy8U9ECbZb/n2KqfpY+7SOah30uYPWfUuw8eU3/y
	SMeTQVN+CA/mW9FEK+YyglalWha5dcQEydqr7GyWNNjSq96A8/4tjsYrtXrlUGrT2dQCO7h10ckON
	B3vi++I8zUOwPH/FKvtG7284t3u3t64r2qCTa0fuSegDRqoqPS6p+gmvpzPzqKxvj4QlMy4dFa23o
	dF4eo7jw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tilKL-00000009tyP-0kBp;
	Fri, 14 Feb 2025 02:21:14 +0000
Message-ID: <0e8c8ead-423a-45f3-9e10-020334ef8907@infradead.org>
Date: Thu, 13 Feb 2025 18:21:08 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: iostats: Update introduction with flush fields
To: David Reaver <me@davidreaver.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Jens Axboe <axboe@kernel.dk>, Konstantin Khlebnikov <koct9i@gmail.com>,
 linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250214013905.60526-1-me@davidreaver.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250214013905.60526-1-me@davidreaver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/13/25 5:39 PM, David Reaver wrote:
> Counters for flush requests were added to the kernel in
> b6866318657 ("block: add iostat counters for flush requests") [1]. While
> iostats.rst was updated with descriptions for the new fields, the
> introduction still mentions 15 fields instead of 17.
> 
> Correct the introduction to state that there are 17 fields instead of 15.
> Also, replace the 2.4 vs. 2.6+ comparison with a distinction between
> /proc/diskstats and the sysfs stat file.
> 
> Link: https://lore.kernel.org/lkml/157433282607.7928.5202409984272248322.stgit@buzz/T/ [1]
> 
> Signed-off-by: David Reaver <me@davidreaver.com>
> ---
> 
> I noticed this small discrepancy while writing an observability tool
> that uses /proc/diskstats. I did a double take because I noticed the
> extra fields in my own system's /proc/diskstats while I was reading this
> doc, but _before_ I got to the descriptions for fields 16 and 17.
> 
> I think the discussion of historical formats for 2.4, 2.6, and 4.18 in
> this document is confusing and not very useful. If you'd like, I'm happy
> to make a patch that rewrites the intro to simplify it and remove
> discussion of the historical formats.

Please do IMO.

>  Documentation/admin-guide/iostats.rst | 33 +++++++++++++++------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
> index 609a3201fd4e..1df7961bdc89 100644
> --- a/Documentation/admin-guide/iostats.rst
> +++ b/Documentation/admin-guide/iostats.rst
> @@ -34,6 +34,9 @@ Here are examples of these different formats::
>     4.18+ diskstats:
>        3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160 0 0 0 0
>  
> +   5.5+ diskstats:
> +      3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160 0 0 0 0 0 0
> +
>  On 2.4 you might execute ``grep 'hda ' /proc/partitions``. On 2.6+, you have
>  a choice of ``cat /sys/block/hda/stat`` or ``grep 'hda ' /proc/diskstats``.
>  
> @@ -43,21 +46,21 @@ be a better choice if you are watching a large number of disks because
>  you'll avoid the overhead of 50, 100, or 500 or more opens/closes with
>  each snapshot of your disk statistics.
>  
> -In 2.4, the statistics fields are those after the device name. In
> -the above example, the first field of statistics would be 446216.
> -By contrast, in 2.6+ if you look at ``/sys/block/hda/stat``, you'll
> -find just the 15 fields, beginning with 446216.  If you look at
> -``/proc/diskstats``, the 15 fields will be preceded by the major and
> -minor device numbers, and device name.  Each of these formats provides
> -15 fields of statistics, each meaning exactly the same things.
> -All fields except field 9 are cumulative since boot.  Field 9 should
> -go to zero as I/Os complete; all others only increase (unless they
> -overflow and wrap). Wrapping might eventually occur on a very busy
> -or long-lived system; so applications should be prepared to deal with
> -it. Regarding wrapping, the types of the fields are either unsigned
> -int (32 bit) or unsigned long (32-bit or 64-bit, depending on your
> -machine) as noted per-field below. Unless your observations are very
> -spread in time, these fields should not wrap twice before you notice it.
> +In ``/proc/diskstats``, the statistics fields are those after the device
> +name. In the above example, the first field of statistics would
> +be 446216. By contrast, in ``/sys/block/hda/stat`` you'll find just the
> +17 fields, beginning with 446216. If you look at ``/proc/diskstats``,
> +the 17 fields will be preceded by the major and minor device numbers,
> +and device name. Each of these formats provides 17 fields of statistics,
> +each meaning exactly the same things. All fields except field 9 are
> +cumulative since boot. Field 9 should go to zero as I/Os complete; all
> +others only increase (unless they overflow and wrap). Wrapping might
> +eventually occur on a very busy or long-lived system; so applications

I prefer a comma instead of semi-colon above. Yes, I know, it was already
like this.

> +should be prepared to deal with it. Regarding wrapping, the types of the
> +fields are either unsigned int (32 bit) or unsigned long (32-bit or
> +64-bit, depending on your machine) as noted per-field below. Unless your
> +observations are very spread in time, these fields should not wrap twice
> +before you notice it.
>  
>  Each set of stats only applies to the indicated device; if you want
>  system-wide stats you'll have to find all the devices and sum them all up.
> 
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> 

LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
