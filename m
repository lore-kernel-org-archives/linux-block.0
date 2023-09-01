Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2153ECA0FE1
	for <linux-block@archiver.kernel.org>; Fri,  1 Sep 2023 13:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbjIANsH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Sep 2023 09:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbjIANsB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Sep 2023 09:48:01 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24C3E77
        for <linux-block@vger.kernel.org>; Fri,  1 Sep 2023 06:47:57 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-790b9d7d643so26388739f.1
        for <linux-block@vger.kernel.org>; Fri, 01 Sep 2023 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693576077; x=1694180877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmFqd0RbA0WcuZBMIdIT4BmUFRAQgFIypD312R8UhzU=;
        b=RuAvsUp/vDVMqUrcJUNtWRXPsqan/zL3OT3gv3mLHMgRHgqE7soRLT3ll/CNacfta0
         afAfDe5ViJRYQKJq7jM7TWyj7tDggyQr0CRjo1+B/Pq7TybY+L+4W8AZMMIucKQWDpoq
         ELHwuiKzAo8UaQqXxBmDTf6WUSz+ztAmcq4ZaIQ+LGkqtCNABqPkSBiIIM89aycytS2d
         aHCl6qr5NHXZdEe5elGFsieIJEfUFsyNlobkRWm00cxqkP1Zrmk/xPRuJDRkwsyYmExH
         D7REQTgu9aeBkLgRr4BUNgejieJL2ASBfbK02iqXNlsKzbB24nrhXRdtVOm1IOYdEtt7
         gb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693576077; x=1694180877;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmFqd0RbA0WcuZBMIdIT4BmUFRAQgFIypD312R8UhzU=;
        b=j8hw+cnnRi/mpmwGf6PzWstfi+7OrHQEVSMf3hG0aipHurB9wxIfucWJfKQuEnwl0V
         k9F/1CxPvNQ5slBlu7lEG/+fekX83Q8dOn03YFgD+/GhA/3682oAO+YgLRU4RlhiTqrg
         xTVVbeLJsWsZS+0V7GUnT46iIVeAaXcg643KqU5wr3bc9DT2YWJS+84LsJPltLuSoRwx
         ixV1vB2E1lRlhZ/z3BR8uuRPAwAIBqo/1qXd3HRaNsH3/6Wpk/vPYI4kZbyP6bcg8f6H
         WwJauFiwAhUzfIJStVuQ+v3u+iGYmEnBDpiOl3t66OouIuIsC3kw02MtX2+bsKopUpts
         Rjfg==
X-Gm-Message-State: AOJu0YxdoH+jX3TMJ7+z4Y1Dhb2ZRsJN3Jz+c8qsUdcogLDCfSNymiZD
        qzzNs9MuCRXzMNu9HvMgvE/d8hfs3nVHoXlfDR0=
X-Google-Smtp-Source: AGHT+IFS0So0giDhkiP6ZhQSrxon+4wrCd3spsAFzBK1P7OazDHtwnuCVD59lDg796XOVHb/T4eHow==
X-Received: by 2002:a05:6602:1a0c:b0:792:6068:dcc8 with SMTP id bo12-20020a0566021a0c00b007926068dcc8mr2692241iob.2.1693576077039;
        Fri, 01 Sep 2023 06:47:57 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u4-20020a6b4904000000b0079216d6f219sm1065493iob.14.2023.09.01.06.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 06:47:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        =?utf-8?q?Jan_H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20230828153142.2843753-1-hca@linux.ibm.com>
References: <20230828153142.2843753-1-hca@linux.ibm.com>
Subject: Re: [PATCH 0/1] s390/dasd: fix string length handling
Message-Id: <169357607517.292044.9672490907419732432.b4-ty@kernel.dk>
Date:   Fri, 01 Sep 2023 07:47:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 28 Aug 2023 17:31:41 +0200, Heiko Carstens wrote:
> since both Stefan and Jan are not available, I'm sending a simple fix
> to address a valid clang finding. Since I expect more reports and
> patches for this, I'm sending this now in order to avoid that more
> people spend time on this.
> 
> Please apply.
> 
> [...]

Applied, thanks!

[1/1] s390/dasd: fix string length handling
      commit: f7cf22424665043787a96a66a048ff6b2cfd473c

Best regards,
-- 
Jens Axboe



