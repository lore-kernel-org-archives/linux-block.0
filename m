Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64E5C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 16:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A51721773
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 16:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfBSQRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:17:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41444 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfBSQRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 11:17:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id d25so2104188pfn.8
        for <linux-block@vger.kernel.org>; Tue, 19 Feb 2019 08:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RiKra5TWKsCnui5LnaCvy11GqRSHcP4MIlWbYMcUP0U=;
        b=D65hupTqOYHeeSdkD/VJP30UmY0aAqWVYR8YnJPo76Z+r9tTlgG81P1NREGl+ezQGo
         T604JKPdFaqlxUS8d/vMRS7UEHBtGrpDdnjyuq3z0zp2dHFpSM0oD/7FqQPZQM0mQFuY
         bddxaLVyUVCROTomEbsI2Rbv56Cpx+IZwCRgKGKZrxXrgAPzr1JMS58495E5eijeT0l2
         SZqpnYonlbe/XWZqwtd+/byC/GNziS8RgbZISQi0GtOk4NZ13wONSjA+Wz9SoQNpXJMh
         qlPbtWVpWntEjUZrSdLvKZN32Lv7QaqKabgrKQMsNhZDzeThvZAjjXBm2tB/k0cZUbdx
         V3Mw==
X-Gm-Message-State: AHQUAuaUHhL77hLu/1jOy811KEMAgeUzXTffXDOFAzTeat8TxxokZyLn
        YRMR9AvqrlFFx7VkwHtiwvg=
X-Google-Smtp-Source: AHgI3IYA6lr8J+DiAvwpsBqA9eDH8oP/ieFtt8i1DEY28XJkHhsXHstLmJVvYaQo0U8EcQMtNwMoFQ==
X-Received: by 2002:a63:e410:: with SMTP id a16mr24818409pgi.28.1550593064169;
        Tue, 19 Feb 2019 08:17:44 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id i14sm10483720pgt.82.2019.02.19.08.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 08:17:43 -0800 (PST)
Message-ID: <1550593062.31902.111.camel@acm.org>
Subject: Re: [PATCH BLKTESTS 3/3] nvme/017: fix output format
From:   Bart Van Assche <bvanassche@acm.org>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     osandov@osandov.com
Date:   Tue, 19 Feb 2019 08:17:42 -0800
In-Reply-To: <1550516022-16374-4-git-send-email-chaitanya.kulkarni@wdc.com>
References: <1550516022-16374-1-git-send-email-chaitanya.kulkarni@wdc.com>
         <1550516022-16374-4-git-send-email-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-02-18 at 10:53 -0800, Chaitanya Kulkarni wrote:
+AD4 Signed-off-by: Chaitanya Kulkarni +ADw-chaitanya.kulkarni+AEA-wdc.com+AD4
+AD4 ---
+AD4  tests/nvme/017     +AHw  5 +-+-+-+--
+AD4  tests/nvme/017.out +AHw 11 -----------
+AD4  2 files changed, 4 insertions(+-), 12 deletions(-)
+AD4 
+AD4 diff --git a/tests/nvme/017 b/tests/nvme/017
+AD4 index 0b86bec..db87759 100755
+AD4 --- a/tests/nvme/017
+AD4 +-+-+- b/tests/nvme/017
+AD4 +AEAAQA -37,7 +-37,10 +AEAAQA test() +AHs
+AD4  	port+AD0AIgAk(+AF8-create+AF8-nvmet+AF8-port +ACI-loop+ACI)+ACI
+AD4  	+AF8-add+AF8-nvmet+AF8-subsys+AF8-to+AF8-port +ACIAJAB7-port+AH0AIg +ACIAJAB7-subsys+AF8-name+AH0AIg
+AD4  
+AD4 -	nvme discover -t loop +AHw sed -r -e +ACI-s/portid:  +AFs-0-9+AF0AKw-/portid:  X/+ACI
+AD4 +-	nvme discover -t loop +AHw grep -q +ACIAJAB7-subsys+AF8-nqn+AH0AIg
+AD4 +-	if +AFs +ACQ? -ne 0 +AF0AOw then
+AD4 +-		echo +ACI-nvme discover command failed+ACI
+AD4 +-	fi

Hi Chaitanya,

Please keep the code style consistent with other blktests code and write that
if-condition as follows:

	if +ACE nvme discover -t loop +AHw grep -q +ACIAJAB7-subsys+AF8-nqn+AH0AIgA7 then
		echo +ACI-nvme discover command failed+ACI
	fi

Thanks,

Bart.
