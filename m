Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4B3C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD89320882
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="miYqHNAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeL0N4G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 08:56:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53174 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbeL0N4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 08:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ekHEDkEKevWLX4mdkKoGYWllFPdhMVkfaceGhi3wo3o=; b=miYqHNAH3wBfj1NRP7rftq8DV
        VGJ5Jl+lpQkVZUFVo9usOd6KelI0GZARQtzxFozjeKwSMI7MuwXUpqi2DXjsZ0nom/lUvgGtaDzk1
        tHrbpYnUC/JDzsz0hbLDv3fZo4GIWYgRhj+VH2n1+g+4RcRTvB1VgCEGrR+HCgun4WyTdUPGTe32x
        QdTgEocexAHl78jYrymo//UqsxyfepWpejLf/Oe5VchN70CMPVsY6yQf515VQykzJwAp3mC9nTjzk
        QvirKYTtqZLHGR/ZPJDk3PHPN16ZV3ThktzG6iZKvjUzXq1CdpbWL0Zom4RwwYgTXiG9Q2nIN7E2U
        jRUbN8Ubw==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcW8l-0006GP-N6; Thu, 27 Dec 2018 13:56:05 +0000
Date:   Thu, 27 Dec 2018 14:55:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 08/22] aio: support for IO polling
Message-ID: <20181227135552.GB25525@infradead.org>
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-9-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221192236.12866-9-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
> index 8387e0af0f76..a6829bae9ada 100644
> --- a/include/uapi/linux/aio_abi.h
> +++ b/include/uapi/linux/aio_abi.h
> @@ -52,9 +52,11 @@ enum {
>   *                   is valid.
>   * IOCB_FLAG_IOPRIO - Set if the "aio_reqprio" member of the "struct iocb"
>   *                    is valid.
> + * IOCB_FLAG_HIPRI - Use IO completion polling
>   */
>  #define IOCB_FLAG_RESFD		(1 << 0)
>  #define IOCB_FLAG_IOPRIO	(1 << 1)
> +#define IOCB_FLAG_HIPRI		(1 << 2)

NAK for this hunk.  We already have a hipri-flag on the command,
which we have to force on, and we have another one on the context.
