Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67370C35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2AC2073C
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="WnodGkM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBKWHa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:07:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34527 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgBKWHa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 17:07:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id j4so96904pgi.1
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 14:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WgVTV7lQE/bIyvaXC07C34YUlrDcd8TvB6ftUOXG7RE=;
        b=WnodGkM11OnywU2OzjV1xqkHM4/hHNpvsrhQIJkenATDhx3P8OWSxO3WSnTw2N7Y1/
         gACqBGW8KQIQjHg1LdckolzuHUwTgaxtwvxkZZo3CRJf5ECYbleKHNir+q7qDdnFO8Ht
         VEU96+vJfj+4+8CnXdcJAl7GTZdP+IMmNx1fKXU0R4o41GF4uBgBoi5064rk9TbfIpuH
         eM+CTToM2as83KSphrWfzLfieEt+eCHz99WS5GVRMYL+AsbIpAGnUGCeeU03cPTXLGSm
         tKm31xgogVl5X5sQNQSi3v4vHIw7dJTfZDrkDKlkJF4K15qdwUiOxy1iTcbFvcizUL6f
         dFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WgVTV7lQE/bIyvaXC07C34YUlrDcd8TvB6ftUOXG7RE=;
        b=Lnr8CvXwRrvy/LpWH7oNTdBYieTObfvTgRkYXWoYy2hSEXS6Ejt65OSaP5V54Zud8T
         dn+Tb6iaf8CS02ofP6Lz056humwj1UaIfBSHbbPyrYateQgjWhlzs23ES8kAr3urfjK9
         5cnRaA4BtSOT3yoCITk95PGMhuF06uzsvPgc0qBfYZjW1uEnMo842CmdWS8w62WnER+g
         OU/SY0DzL4jaqqS9rqF0LD4U+NFEaCwAriS8WQH565jtVZ+P/+YJrWzVBkHarLDtW2Vt
         glVMP/xjh7sLj9uHstiucw72H0Vy1beaH5ScbxD8IurLVzwcAgH5UM53HLRZQg8UZj0o
         wbPw==
X-Gm-Message-State: APjAAAXs8i8EakPxAX/Oa3VdaElfExTz/MTVP34uFWyNY1pVCsU0VN65
        gxL7wzhizYff37NLCk7n4/FScA==
X-Google-Smtp-Source: APXvYqzC/8Wpkw9hgpOc5mN0QFy0feFu+Zy8uP+RivPzgRjbR7PCRErpak8CPxT/HhYm+2vt3vNcaQ==
X-Received: by 2002:a63:2f46:: with SMTP id v67mr9519142pgv.220.1581458849691;
        Tue, 11 Feb 2020 14:07:29 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
        by smtp.gmail.com with ESMTPSA id r62sm5619461pfc.89.2020.02.11.14.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 14:07:29 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:07:28 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Message-ID: <20200211220728.GG100751@vader>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB5749FE36341AB61547C1218A86000@BYAPR04MB5749.namprd04.prod.outlook.com>
 <BYAPR04MB574971DCB7CF63F7A4A269B886180@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB574971DCB7CF63F7A4A269B886180@BYAPR04MB5749.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 11, 2020 at 04:46:05PM +0000, Chaitanya Kulkarni wrote:
> Ping ?

Whoops sorry, these don't match my email filter that looks for "PATCH
blktests" so I missed them. (You can make git do that for you with git
format-patch --subject-prefix="PATCH blktests", by the way.)

Thanks!
