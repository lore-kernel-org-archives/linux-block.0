Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66185C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 01:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiAJB7m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jan 2022 20:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbiAJB7k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jan 2022 20:59:40 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4FBC061751
        for <linux-block@vger.kernel.org>; Sun,  9 Jan 2022 17:59:40 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y70so15629567iof.2
        for <linux-block@vger.kernel.org>; Sun, 09 Jan 2022 17:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=X1XWCuDCwP2Vi5jZjH2p1KzFJ1LWZqjX5NlnfaMgBKU=;
        b=hINncY3uYTC83lQS15HGGd9lnWsX3ziGG2R7V5dGktSlsRC+6nBPuPTOh2zduhn/m8
         Iw+Q3cX0BUfEFhzSvTwJc6KjVifhrrlqVF4SETxF7pdPCwFQ9cKi9OQJg66T8Ac+J2e4
         r0tkOEc52i4lRZU0NhNFXVEYtGc+a7AKmQwLAzpl/ubLtZc8Qc9oiyXg3h8xcP27gszC
         smcotpVYNj/YzQx5ZfCmVahvb+eEhH+MJhKECYYsNtRGv9V+twuuabnPv9VgasywcMmC
         Skwc1xU9FmLn1Se2bcJPCkWihKiioGrrkWQCEPIkEFdy8X9mmu5i9kl9uvdqP9by/Sfy
         WUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=X1XWCuDCwP2Vi5jZjH2p1KzFJ1LWZqjX5NlnfaMgBKU=;
        b=f1Kx8IuLRZI+aYEfOffP9DHkYhAYZLuRnqRsFkAMHiDzOJut/UvtOCRZalwp+spEfW
         gOL5PQUqdB3Xphx4+WQGJHL7BBNARCtEDHwWkTFfy8SjYdnZxY1j6q189urGSgQgKQFi
         EU+nFDxtf74oFv0aG7xv5zB+78GN469NhtalHon0TO8MLQWWv8RFEWHkGjHXDpeSVaoC
         zqQnVP2CBSFRTkU4uvIYZ+y9jcq1jh/mDSgHV1N4QSNbmvEVhjj2RYMDPTpaBmeo6pdE
         n5i8lrzn9pe+RDzRXoHkfMqoiGFyw2n1sYLcDDhcD0oMb4gCcN3j9OghGb0Q+u1Kj3ut
         UYCQ==
X-Gm-Message-State: AOAM5307L2iLEAukmc1T+HH2xeMZza8WHqIdQ7ewRj2Vg41dYMrGUjKy
        j0R8/SAvHliYYPn+PmkA7bb2iA==
X-Google-Smtp-Source: ABdhPJywjwK1mGzwUiV8AsYEFVjPuTCfwaBPnYXlxGJFIrbABsReecIdn6e6r0hg98xnc59Yu675Ug==
X-Received: by 2002:a5d:9582:: with SMTP id a2mr34171969ioo.81.1641779979403;
        Sun, 09 Jan 2022 17:59:39 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l14sm3705382ios.24.2022.01.09.17.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:59:38 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211209003833.6396-1-ebiggers@kernel.org>
References: <20211209003833.6396-1-ebiggers@kernel.org>
Subject: Re: [PATCH v3 0/8] docs: consolidate sysfs-block into Documentation/ABI/
Message-Id: <164177997844.87165.14602607472364382040.b4-ty@kernel.dk>
Date:   Sun, 09 Jan 2022 18:59:38 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 8 Dec 2021 16:38:25 -0800, Eric Biggers wrote:
> This series consolidates the documentation for /sys/block/<disk>/queue/
> into Documentation/ABI/, where it is supposed to go (as per Greg KH:
> https://lore.kernel.org/r/YaXXpEAwVGTLjp1e@kroah.com).
> 
> This series also updates MAINTAINERS to associate the block
> documentation with the block layer.
> 
> [...]

Applied, thanks!

[1/8] docs: sysfs-block: move to stable directory
      commit: ae7a7a53498f452eb927cd4b4eed0bccded85ebf
[2/8] docs: sysfs-block: sort alphabetically
      commit: 07c9093c429361dd405499b1e433e4170b81551f
[3/8] docs: sysfs-block: add contact for nomerges
      commit: 8b0551a74b4a9396a7f6ddb0c5f6f3c8465e9d45
[4/8] docs: sysfs-block: fill in missing documentation from queue-sysfs.rst
      commit: 849ab826e10531f106846e8e9eeae8d00a198f6e
[5/8] docs: sysfs-block: document stable_writes
      commit: 1163010418a7f0c60c309743498cb6c5cd828ecc
[6/8] docs: sysfs-block: document virt_boundary_mask
      commit: 8bc2f7c67061cb39e317a45ad9870f529b1fb190
[7/8] docs: block: remove queue-sysfs.rst
      commit: 208e4f9c0028e9181220460600b1df0bc677e796
[8/8] MAINTAINERS: add entries for block layer documentation
      commit: f029cedb9bb5bab7f1bb3042be348f2dac0ee66e

Best regards,
-- 
Jens Axboe


