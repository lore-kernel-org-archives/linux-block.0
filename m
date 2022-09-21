Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E4FC6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 14:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIUOhC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 10:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIUOhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 10:37:01 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28461895E2
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 07:37:01 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y9so3215980ily.11
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=2PJ7mUrSV3d/EEO99tJFQt9AbdRDwWYt70eWZRfTg+w=;
        b=K0W+V6XMQMc4HbHBUosgF9SpxnuEvs176WSWL9RmRcRKBU8K1ypiDPiAEih/bwipBM
         H6tGvn+2GlYE5QG5+KTNeIXVAtM4tczzS9DsEyGQcKpb3GTDro3J2NQTCGOVgEaZgA8E
         4XQ1lfQOKaTuAyYV4FwSyRN5ULtaX8WYSmCPVFp8wKcy9B6nTLDOIzk3afsBGVfKejNK
         PVNH1tG+Y29dMP416W2lWT9ktEls3TE3yk4uua0P8gzuE+ZX1L9TZ0I1HHA8hPSWyltG
         Mpz5++aNkX6dQlUqY5vIQqxU22OhyGEV7VJohL7pfjuRrFa/nAQWeVOZ0STZqCjBFH61
         C7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2PJ7mUrSV3d/EEO99tJFQt9AbdRDwWYt70eWZRfTg+w=;
        b=UMd7FpQ9ZSFONh2UnRwVA1avrvmefeQnqzLPfgppo7q137jfh24/JtzJMV99EQ9hmI
         vSxMqyQRP7Sx52967nq0vm4j2yKndKncixSCPn4XMy3QtOTOIsr9vqXINH3Mk02zZREV
         /vKwyrl8sWCH0J8AEkQHgVp8dqtJ/GROOMLNjicj6xZchbP96nIw98adT1/wJRk8wSkO
         u49LL5dRtrJfkE9T6JpLC8bgBCPy1+7GtYftwgu5CAFqcKL/OtekuxNWQb4ErQOOmoqG
         m4M9ZKnufDBt96GCFrINTJ8a7kXvM4dxVSNFcY1gJNy6xr3Jauzu5184eANgw3QEF5tM
         gy4g==
X-Gm-Message-State: ACrzQf2o0Kwe9O+vJ/RJSU6vUS3Eqzc5fDbB1O51olGbwTL/B+eWNfr9
        aMTwoOUUhsZiX8mhP/B9+pUo5iHjg9npRA==
X-Google-Smtp-Source: AMsMyM5kX6grzFPuCSlMHELCEDjwzyXoTaYOHTf+6cU8Vkhjvll6mH2g+6HeyV+4ViIAIEzjH5KHCg==
X-Received: by 2002:a05:6e02:1b83:b0:2f5:3d65:6bca with SMTP id h3-20020a056e021b8300b002f53d656bcamr9108102ili.279.1663771020471;
        Wed, 21 Sep 2022 07:37:00 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a14-20020a056602148e00b006a0d1a30684sm1215802iow.33.2022.09.21.07.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 07:36:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
In-Reply-To: <20220920192616.808070-1-sth@linux.ibm.com>
References: <20220920192616.808070-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/7] s390/dasd: add hardware copy relation
Message-Id: <166377101952.42670.6992780318045697672.b4-ty@kernel.dk>
Date:   Wed, 21 Sep 2022 08:36:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 20 Sep 2022 21:26:09 +0200, Stefan Haberland wrote:
> please apply the following patchset to for-next.
> It adds basic support for a harwdare based copy relation to the DASD
> device driver.
> 
> regards,
> Stefan
> 
> [...]

Applied, thanks!

[1/7] s390/dasd: put block allocation in separate function
      commit: 2b43bf061b2e1b67561cbb1f6f305421f5fc86af
[2/7] s390/dasd: add query PPRC function
      commit: 3f217cceb6846e7533511fc69bc774cdba37ff7d
[3/7] s390/dasd: add copy pair setup
      commit: a91ff09d39f9b6545254839ac91f1ff7bd21d39e
[4/7] s390/dasd: add copy pair swap capability
      commit: 413862caad6fe7fddec639219bccfdab60333551
[5/7] s390/dasd: add ioctl to perform a swap of the drivers copy pair
      commit: 112ff512fc654d7066936dcc06f77cc60471fdb4
[6/7] s390/dasd: suppress generic error messages for PPRC secondary devices
      commit: 1fca631a1185d1de9eab65ee963fec20efcc528a
[7/7] s390/dasd: add device ping attribute
      commit: 32ff8ce08b47a5fe64ef9827443ba6cc49a659c8

Best regards,
-- 
Jens Axboe


