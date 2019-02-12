Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1952C282CE
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 08:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D5B21773
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 08:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q/FBsIup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfBLIDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:03:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLIDU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 03:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LFs6wMRR/DA24qV457yEoLv2f9Ha8eqyvlq8xUSxZb8=; b=Q/FBsIupgqdGcbabZAPNrSnv+
        MgoSLQCkV1vT+xmrH/7/ivhlU0OqBSOZRUzF0aBYRxhvHI3PHQhyL1qo5Fi5c2cTiHL50kLlNA2yf
        LyooDNYKei2Wz2F+dosdOmqGRPFvLVtO5ZedZPeh1oEaXneAHYHwNzb0BZ0KLq5e4xmH+XYKwbO2i
        Gl5sM0DYcbg037DhgMSpxs0RpeoRJK261KF8q/t19nTLZoKo2+7Q8V4IVzVpj3Q89uOBbdhF/YL5B
        5eeXsvP7YinS/apMskVjrYjRV+/Sdl0FZBNpo0jXhiVXxOmT8AiTyVlxC2ysN2I7ewB2Qxst5Wmxe
        6q43r43Zw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtT2G-0006tF-2Z; Tue, 12 Feb 2019 08:03:20 +0000
Date:   Tue, 12 Feb 2019 00:03:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>,
        Oleksii Kurochko <olkuroch@cisco.com>, stable@vger.kernel.org
Subject: Re: [PATCH] scsi: sd: block: Handle cases where devices come online
 read-only
Message-ID: <20190212080319.GA10547@infradead.org>
References: <20190208233831.31377-1-martin.petersen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208233831.31377-1-martin.petersen@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 08, 2019 at 06:38:31PM -0500, Martin K. Petersen wrote:
> Some devices come online in write protected state and switch to
> read-write once they are ready to process I/O requests.

That is really weird.  What kind of devices are these?

> Note that per-partition ro settings are lost on revalidate. This has
> been broken for at least a decade and it will require major surgery to
> fix. To my knowledge nobody has complained about being unable to make
> partition read-only settings stick through a revalidate. So hopefully
> this patch will suffice as a simple fix for stable.

Should we warn when we lost these settings on a revalidate?

I have to say I don't like the tristate too much - it seems to allow
setting a hardware write protected device writable again by user
interfaction, right?

Should we just have a hardware and a user policy field that are separate
instead?
