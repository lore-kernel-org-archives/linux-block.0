Return-Path: <SRS0=IU7b=QD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA859C282CA
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 13:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F58721736
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 13:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Y9yemNwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfA0Ny1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jan 2019 08:54:27 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41281 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0Ny1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jan 2019 08:54:27 -0500
Received: by mail-pf1-f173.google.com with SMTP id b7so6808071pfi.8
        for <linux-block@vger.kernel.org>; Sun, 27 Jan 2019 05:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6OgZB8xG/BSyu6eQiQHVUR7Tc7GW2XIC/DivkPKRUbY=;
        b=Y9yemNwHTvxUZznGN10zDwkVPbrGsgjoiTZW1oILqTUbAWZovwWOcrw+sTOY8zrgsZ
         Lf4fm209cbVx6lWs7xx7wFoDEfbAKTqmU2scywy1KfVSZ2Hk+u+jeIxKAOuEiiYNNVij
         bKyFtMsOP1tDjZjMW9hVsJaJB6RJidAHCL6IKeomMlIPpaCYJJz2wJ5pmS6+5/kCakmz
         GJnEdRff3089OU+diz/CGDGyo5Pk85Rdz5Nnij39tyKCapW/XwiLVKfT4ZvD8foro2bE
         t3bhUrQxGsLXkbQc6FA+FhtJT9DJrAuCLbmNQ//aOvWs1EmGrlRlON0mcqyRWxb0mgXz
         1KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6OgZB8xG/BSyu6eQiQHVUR7Tc7GW2XIC/DivkPKRUbY=;
        b=pcSt7Mnn/hKpCACUSMGQPQ2CfqCrZURhy2cQYTMX7Q4k8e7kHu23BqgEYyUIIIhNpQ
         bgmbLHU/kgA+TQpzC2p4RSDEepQZLbKo6Li7UstmV7wdDH7dT9y7vrwMnrHDCcbKtY+D
         Kh5LbO2s+qxQYBbUY+9+qH0Gajlo7xvnF59IzYvUg1ReQQoTZcCxf1JgnRohLzqmJLT6
         pmXDfCzViJN/d9wYS/RVbMUqs9zn7cuaIP8IktDQZ3+ctkGqbPV4uciIxYK/3dO8VAvD
         eXx9oQIR3e9Wy5RquswzkELoqclAr0bInOMJFjuEccpjaSzbQAK2niunqk8vKrwEJOxX
         oh+g==
X-Gm-Message-State: AJcUukcn5NhJzQ/xIvRD6USbObtFuoolitvM3d6KIHykX9LVMogT39ci
        qsm4MjOAs8bvFQcQ5dmKrmedppwT8Ac=
X-Google-Smtp-Source: ALg8bN5RcKwY0pBSHSIAoz7XmkQ6pdoGCtyCF5coJkRq+G72PcOpxBV0+SqJzcHJdavtKU1zk9tKfg==
X-Received: by 2002:a63:2d82:: with SMTP id t124mr16420385pgt.260.1548597266426;
        Sun, 27 Jan 2019 05:54:26 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p6sm42337239pfn.53.2019.01.27.05.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 05:54:25 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Single block revert for 5.0-rc4
Message-ID: <c47c7c79-5fda-bd0e-f308-5e989cc2cacc@kernel.dk>
Date:   Sun, 27 Jan 2019 06:54:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Silly error snuck into a patch from the last series, let's do a revert
to avoid a potential use-after-free.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190127


----------------------------------------------------------------
Jens Axboe (1):
      Revert "block: cover another queue enter recursion via BIO_QUEUE_ENTERED"

 block/blk-core.c  | 11 -----------
 block/blk-merge.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 11 deletions(-)

-- 
Jens Axboe

