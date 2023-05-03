Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA72C77B75
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 19:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjECTLs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjECTLr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 15:11:47 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F2B7AA3;
        Wed,  3 May 2023 12:11:44 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-306281edf15so4858551f8f.1;
        Wed, 03 May 2023 12:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683141103; x=1685733103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54FcX7m56ayBWjcvud1Kf/5sZaGwEHaWh+uspYclntQ=;
        b=Mpz4hTf3Xp44JTzlnxjhUNRd8Hwn0unWpsdfKLEYhvCSgYWfYX7rC89PVZ/TRcErr4
         76uZQy14HkwfLJZfP+LhDE9qbBDc4tF5TQncPkhYaxEhzl3qqntjSu7N1948sPbB0p7A
         kbOmsrPEwIdKhbZVesPMGDoP2GPBQueDREcQimlsKbFFwxBHCqgpSrQ2b9T2pT0+KVss
         lopUUIVea47bJCipnzRnFuEqinp9TNcuTeF/clMZyAoXNSDflvd4/JvBJ/otPttdkfO+
         AD2m2r7X4UwEbusT9ochfmZ76pGwGT/D/azz3cFYqHpYzptlVjz9CkHnOXZW3pJCi0yZ
         Hbmw==
X-Gm-Message-State: AC+VfDw1g2VTld7hDdDtDqUiAvLT+ZAUD9OnCsRhBBNLV0orOG/FhpiO
        pnkWPQOfex4czW9wTuPMcqY=
X-Google-Smtp-Source: ACHHUZ6HDa6PpE0QZkVce9/fw7pukp37W1XiFxrwL1kOk7bquMTIwotFwziRSBw5lTeJ/dgM0pLGRQ==
X-Received: by 2002:a5d:6b09:0:b0:306:2eab:fb8c with SMTP id v9-20020a5d6b09000000b003062eabfb8cmr771025wrw.42.1683141102639;
        Wed, 03 May 2023 12:11:42 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-029.fbsv.net. [2a03:2880:31ff:1d::face:b00c])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b002f103ca90cdsm34480997wrp.101.2023.05.03.12.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 12:11:42 -0700 (PDT)
Date:   Wed, 3 May 2023 12:11:40 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        asml.silence@gmail.com, axboe@kernel.dk, ming.lei@redhat.com,
        leit@fb.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
        kbusch@kernel.org
Subject: Re: [PATCH v3 4/4] block: ublk_drv: Add a helper instead of casting
Message-ID: <ZFKx7Kn2Q3qiKfze@gmail.com>
References: <20230430143532.605367-1-leitao@debian.org>
 <20230430143532.605367-5-leitao@debian.org>
 <20230501043122.GC19673@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501043122.GC19673@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 01, 2023 at 06:31:22AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 30, 2023 at 07:35:32AM -0700, Breno Leitao wrote:
> > ublk driver is using casts to get private data from uring cmd struct.
> > Let's use a proper helper, as an interface that requires casts in all
> > callers is one asking for bugs.
> > 
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> 
> No, I've not suggested this.
> 
> > +static inline struct ublksrv_ctrl_cmd *ublk_uring_ctrl_cmd(
> > +		struct io_uring_cmd *cmd)
> > +{
> > +	return (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
> > +}
> 
> I've two times explained we need a core io_uring helper to remove this
> casting in the drivers, and I've explained how to do that and provided
> the actual code for it.

Sorry for it, somehow I misunderstood what you meant. I re-read the
thread and got what you said.

I am preparing a V4 with the new approach, and I will send it tomorrow.
