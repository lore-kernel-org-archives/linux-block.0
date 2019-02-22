Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5CFC10F00
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 14:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D01F2075A
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 14:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R44PwDnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfBVO36 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:29:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfBVO36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 09:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tV7/ZUUnQkgXTN/RgSMQ3P/5vAkm/xeBqs7j5CBlguc=; b=R44PwDnDa5rkopkzyWUS1S5ZA
        j9UAuW4rPt+teUoRuNSeFjp5zczWkxoZdggftuHJ87jitMB1x3vzfT+fMb5yqNQRtQyKLJuexZPdS
        3ss2c9wAHOJQBH2EAkuF9IPRrbXfG/jdM1dDjVoK4BztoQg3+WqTkrzQBpik1fk/cEN+AOHNF8AsY
        SIoHIbw2oraxxnKjZSVVBCFELqUdcqNuxeWT3cU/Jw5UXk6cXNcYEZUoWcOMJxTShpaxJWlU7PM0V
        I6avqRpsdbPOJx16kuruW61kszAW//FX1UpEzeSk1OHFbzu7Vylf1uy6Y204QMWl61gGRxz+51eqP
        KbWlcH2VA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxBpt-0004uB-J6; Fri, 22 Feb 2019 14:29:57 +0000
Date:   Fri, 22 Feb 2019 06:29:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>,
        Oleksii Kurochko <olkuroch@cisco.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] scsi: sd: block: Fix regressions in read-only block
 device handling
Message-ID: <20190222142957.GA17324@infradead.org>
References: <yq1d0nxuf73.fsf@oracle.com>
 <20190213025717.20057-1-martin.petersen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213025717.20057-1-martin.petersen@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 12, 2019 at 09:57:17PM -0500, Martin K. Petersen wrote:
> Some devices come online in write protected state and switch to
> read-write once they are ready to process I/O requests. These devices
> broke with commit 20bd1d026aac ("scsi: sd: Keep disk read-only when
> re-reading partition") because we had no way to distinguish between a
> user decision to set a block_device read-only and the actual hardware
> device being write-protected.
> 
> Because partitions are dropped and recreated on revalidate we are
> unable to persist any user-provided policy in hd_struct. Introduce a
> bitmap in struct gendisk to track the user configuration. This bitmap
> is updated when BLKROSET is called on a given disk or partition.
> 
> A helper function, get_user_ro(), is provided to determine whether the
> ioctl has forced read-only state for a given block device. This helper
> is used by set_disk_ro() and add_partition() to ensure that both
> existing and newly created partitions will get the correct state.
> 
>  - If BLKROSET sets a whole disk device read-only, all partitions will
>    now end up in a read-only state.
> 
>  - If BLKROSET sets a given partition read-only, that partition will
>    remain read-only post revalidate.
> 
>  - Otherwise both the whole disk device and any partitions will
>    reflect the write protect state of the underlying device.
> 
> Cc: Jeremy Cline <jeremy@jcline.org>
> Cc: Oleksii Kurochko <olkuroch@cisco.com>
> Cc: stable@vger.kernel.org # v4.16+
> Reported-by: Oleksii Kurochko <olkuroch@cisco.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201221
> Fixes: 20bd1d026aac ("scsi: sd: Keep disk read-only when re-reading partition")
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> ---
> 
> v2:
> 	- Track user read-only state in a bitmap
> 
> 	- Work around the regression that caused us to drop user
> 	  preferences on revalidate
> ---
>  block/genhd.c             | 22 +++++++++++++++++-----
>  block/ioctl.c             |  4 ++++
>  block/partition-generic.c |  2 +-
>  drivers/scsi/sd.c         |  4 +---
>  include/linux/genhd.h     |  2 ++
>  5 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 1dd8fd6613b8..34667eb1d3cc 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1544,19 +1544,31 @@ void set_device_ro(struct block_device *bdev, int flag)
>  
>  EXPORT_SYMBOL(set_device_ro);
>  
> +bool get_user_ro(struct gendisk *disk, unsigned int partno)
> +{
> +	/* Is the user read-only bit set for the whole disk device? */
> +	if (test_bit(0, disk->user_ro_bitmap))
> +		return true;
> +
> +	/* Is the user read-only bit set for this particular partition? */
> +	if (test_bit(partno, disk->user_ro_bitmap))
> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(get_user_ro);

No need to export this function.

> +	p->policy = get_user_ro(disk, partno) ?: get_disk_ro(disk);

Can we avoid the obsfucating non-standard (GNU extension) use of ?: here?
Just use a local variable and a good old if.
