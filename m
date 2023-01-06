Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708DCC54EBD
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 19:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjAFTRY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 14:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjAFTRX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 14:17:23 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158E8A3
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 11:17:23 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id t15-20020a4a96cf000000b0049f7e18db0dso698690ooi.10
        for <linux-block@vger.kernel.org>; Fri, 06 Jan 2023 11:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPMCgZhfjIqLlZSt80mt/MRb1U8G1aCCF1CW+pU7nac=;
        b=KaiVt9rKM65zPESuFOVGS1v+/3JN6NVMPQQEUcXYqixO60rEYkxp051HpigqjR51l/
         nrO7HVdyQCS7CikIffgGj+uejriUtWp8T8DPnu2unjyioiDVZrCpA+4B51wPxk9S4Nbu
         pl/JIfvgcUDCpZQ1yj08gy4UNG9FfS7GsSyPcqjJMOmNdfFWksedDu1CmVZlHP4wHyvI
         XGCJKspb1aRKaISObbr5xsiSPCo0umh6PusOPUegj3zCSCCzsB9SXeTABxBOTbfjPZ0z
         uuJr4ngWlik6jHtmfl2iMQZ76eUa6EkkTsJXC5XT+3tXTNekm/a+8t4vuKKbEl5qW6fR
         Q2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPMCgZhfjIqLlZSt80mt/MRb1U8G1aCCF1CW+pU7nac=;
        b=Z1MDEEawK3tB3/oiOFO3iAhLcl5O3E451L5eou2Y9dmSFpl3FioSohjN+3e+5MDcXq
         jT66Ise2ys6A0Nwx1l5XT3Qn08nvWCuOIOiWNgwann8VPZuZbC78E4gNURncliC29Jmg
         puRPAQhrt+5urwjb+RYE5IJQswz0K0qBdsBVAI/p+srw/399tFZ3by+GmlFkA5vN/5No
         0g8IdeLcNiC7Upwv1wFNj0yvM219XE9bPFkykuvX4ngUOcouqldzvuK/Tdo5hlOEJxJv
         TunIuP3vsh1KPTDkQacgsigyjflN/R2V2DT7YJLDUuQuPS/AszfAuckEoHo+7MPRRIHm
         o9XA==
X-Gm-Message-State: AFqh2krXptSutv0aUEjxWbVBaFVioWm3hLD2QefVTPjiBmcZn+lvchyP
        9I5KzFnrv5WzHiitiRC3JJHIN/b5dayNgNWStnhFkQ==
X-Google-Smtp-Source: AMrXdXton316KXaX80FK7xrsgx50aENyoJnxyNzKnafl+WXc6mJJNK11EKPRNTMiM+exSjlm1hzBWw==
X-Received: by 2002:a4a:bd94:0:b0:49f:f3ef:33b3 with SMTP id k20-20020a4abd94000000b0049ff3ef33b3mr27165983oop.7.1673032642241;
        Fri, 06 Jan 2023 11:17:22 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id bb9-20020a056820160900b0049be9c3c15dsm775975oob.33.2023.01.06.11.17.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2023 11:17:21 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: [LSF/MM/BPF BoF] Session for Zoned Storage 2023 
Message-Id: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
Date:   Fri, 6 Jan 2023 11:17:19 -0800
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        "Viacheslav A. Dubeyko" <viacheslav.dubeyko@bytedance.com>
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I would like to suggest to have ZNS related session again. I think we =
have a lot of to discuss.
As far as I can see, I have two topics for discussion. And I believe =
there are multiple other
topics too.

How everybody feels to have a room for ZNS related discussion?

Thanks,
Slava.=
