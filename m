Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36F9C0015E
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 19:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjGUTVx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjGUTVw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 15:21:52 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9472E189
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 12:21:50 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-785ccd731a7so28104839f.0
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689967309; x=1690572109;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FKs38S7eNYKC6MvhREgUk9k7CI4DUBXE1EUMmhaeuo=;
        b=aCsQb22tE2Q3ASnQKvDbAu3s2uZbwtPzkZ3CLMgR9gc9bXU3MtQkdE9caOQ3fPNORz
         u9KuNDwPGFfU6fMUuAEh6gg+mPP6GO1NVmN8iRsxG87iBJNSUeUxNdyARVkVFRwc3n/Q
         1JYC08y/GTWApahaHegpyJY64gB62T0OSa/rP07VXGU1rF3+mglm6sDnLSuvv+nV3H66
         EK6vz9p8N/C24Gic+giJBhqCEG35nLqVhJ8NrQJSNVRqszQYTr4+ECJYWjm5+YyRf/ot
         9ofXnQWeR3KyRjMn5UYcvgWwRPKxqo/LZ/4hQ+cbDSQ/Wg7zsz0ZGSd5/lparrXBRhyR
         xn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689967309; x=1690572109;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FKs38S7eNYKC6MvhREgUk9k7CI4DUBXE1EUMmhaeuo=;
        b=i+aWukwN80TVz14ggWJaj/xutN2O/7qHDiH/sbrFSJ6okWK1uUaUIV3jNpKqorN5fN
         VWuxOBjlKWXd4sZw88EdDIJ8NPGFUbvTccHpBlywIBh5oPyjuwpWieJvU/H9Sl0r60U5
         klPql2Ul7zQ0eK5WZOvlIZ7DSiFCpbmkbeZOKoEWF4NRhjNbfyx3faOVp/Xn6Z91Lm45
         jV1Q/RmSDlbHvVIlxWD/yj/MGsMzFS8mkH/eYUTNbzimSBpF2zZummlL6dfnhm86LOfG
         eL2r9Arn/5A/G/T4GwZJfyfQOL9KOInClFm5oN8ge7lLcU9iRfet12lUtgWRdPn0FEBx
         T5qQ==
X-Gm-Message-State: ABy/qLZfFiLTNXNspk8VULS52fq9lMV4cGLQ2OSHJuJDEDv6ACboFz6s
        5QbkV+GufymMxOX4UQMa+icHrGE5204SqYF0JCM=
X-Google-Smtp-Source: APBJJlHaeHwfyZYOPJ6H0rPeRESAy4ixb7/z1KB4YU3qeKLDQOid3iiESLhC5o83TVyw/LO6KfkR/w==
X-Received: by 2002:a92:d748:0:b0:345:e55a:615f with SMTP id e8-20020a92d748000000b00345e55a615fmr2470098ilq.2.1689967309547;
        Fri, 21 Jul 2023 12:21:49 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u12-20020a056e02080c00b0033e62b47a49sm1160743ilm.41.2023.07.21.12.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:21:48 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
In-Reply-To: <20230720143033.841001-1-mfo@canonical.com>
References: <20230720143033.841001-1-mfo@canonical.com>
Subject: Re: [PATCH v2 0/2] loop: fix regression from max_loop default
 value change
Message-Id: <168996730871.456252.2356504619291334379.b4-ty@kernel.dk>
Date:   Fri, 21 Jul 2023 13:21:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 20 Jul 2023 11:30:31 -0300, Mauricio Faria de Oliveira wrote:
> Apparently, there's an unintended consequence of the improvement for max_loop=0
> in commit 85c50197716c ("loop: Fix the max_loop commandline argument treatment
> when it is set to 0") which might break programs that handle /dev/loop devices.
> 
> The (deprecated) autoloading path fails (ENXIO) if the requested minor number
> is greater than or equal to the (new) default (CONFIG_BLK_DEV_LOOP_MIN_COUNT),
> when [loop.]max_loop is not specified.  This behavior used to work previously.
> 
> [...]

Applied, thanks!

[1/2] loop: deprecate autoloading callback loop_probe()
      commit: 23881aec85f3219e8462e87c708815ee2cd82358
[2/2] loop: do not enforce max_loop hard limit by (new) default
      commit: bb5faa99f0ce40756ab7bbbce4f16c01ca5ebd5a

Best regards,
-- 
Jens Axboe



