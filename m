Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13985C77B61
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 01:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbjD1BPd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Apr 2023 21:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjD1BPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 21:15:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7FC26A2
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 18:15:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b8b927f62so1901890b3a.0
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 18:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682644529; x=1685236529;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdAMIiYmqSQz1GbWDTNHZpSZR6NUQD27x8IVMPn6Rlk=;
        b=sa+18BQfIXdO34J2oBZ5fSNZDw2+/e2xdxFJ6iVqaxb1QxklxwVdWMI6yAs6m/RXcG
         hfCvJZzISTfabi+tC/OLXZyJxmQaWFrefjil/FlgPAPMdVKcCqbLhRn+h8eIWvXlS8iJ
         /I/b9TjLaNJB9EVoYkWPxoRdY4h6oGKU7HwGje2SXoKok/o3pDz+eEsBMclToXbyGCZG
         mFWMsHrQiSG51MpgLF6Vm4jULI7sg02cU6J3SmaHgwSwUU0fEn/C0JuSqoGjF2+SJ95c
         LdX+qb1fRPWe/Sy/EGOigwFdj+uTAUfnCPj7I+qWoFvYbU7FOqL4/hDVkR0bpJetnn2J
         DT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682644529; x=1685236529;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdAMIiYmqSQz1GbWDTNHZpSZR6NUQD27x8IVMPn6Rlk=;
        b=eYJbrShcqoYtqRQJ4kYDy502UrfFq4pIyNfeLUaygtkDpFUbH3rquC043xFCeiVfy7
         7cK12qHeB7l8S2aHFR40znvuPKE/b2w2RNCY/mHAycIsgGJKD3NCd8ZDFqv+ejGi00hs
         C0KsTSdgd2Ky/B/1w1ar6Bgnh5KdnB1XSoJLRySEiNIHQTnbGI/6HkeGsS+X9n33f54a
         4IyplbBBcjk5+gkE6RHEC18yfqU0RF66MX2ttK16BI/pz95qvd9X61is9y14bzaiFanY
         1UBj0QQS3K9+8fEuNhvWIGDnh1I7lK38pVsABIBxZWnI9oQ9OgRg0EFjDRoMYpQG2uIP
         fUSg==
X-Gm-Message-State: AC+VfDxCTV5KXGh36RzX2JYCu0eYdSNHAhCgPdmEQ+5WbThOk05HV5pm
        57PcNFEsMJIdOgY9GKkx4NYn9w==
X-Google-Smtp-Source: ACHHUZ7X+opn2Ubw1AwkQMzsSBun7dBZmvM343LIKmA46Kxphf9kLViwUZGrEMzvdhctRRtKV/mFeQ==
X-Received: by 2002:a05:6a20:7f99:b0:f6:d60d:dbc8 with SMTP id d25-20020a056a207f9900b000f6d60ddbc8mr3325695pzj.2.1682644529298;
        Thu, 27 Apr 2023 18:15:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id om12-20020a17090b3a8c00b002405d3bbe42sm13893828pjb.0.2023.04.27.18.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 18:15:28 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, Eric Blake <eblake@redhat.com>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230410180611.1051618-1-eblake@redhat.com>
References: <20230410180611.1051618-1-eblake@redhat.com>
Subject: Re: [PATCH v3 0/4] nbd: s/handle/cookie/
Message-Id: <168264452819.133910.16210912670607469975.b4-ty@kernel.dk>
Date:   Thu, 27 Apr 2023 19:15:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 10 Apr 2023 13:06:07 -0500, Eric Blake wrote:
> v2 was here: https://lkml.org/lkml/2023/3/17/1107
> since then:
> - squash patch 2/5 and 3/5 into 3/4 [Ming]
> - add Josef's R-b
> - tweak commit messages to match commits in userspace NBD (code itself
>   is unchanged, modulo the patch squash)
> 
> [...]

Applied, thanks!

[1/4] uapi nbd: improve doc links to userspace spec
      commit: daf376a366fd2d469d66ab83dfdc074777462bab
[2/4] uapi nbd: add cookie alias to handle
      commit: 2686eb845da7762ee98b17e578b0c081aafb77b9
[3/4] block nbd: use req.cookie instead of req.handle
      commit: bd9e9916c32fd4b4fb4e879e05bd1568ee02ec93
[4/4] docs nbd: userspace NBD now favors github over sourceforge
      commit: 952aa344bf4305ab6fa0d9962ef8c2caa2afef4c

Best regards,
-- 
Jens Axboe



