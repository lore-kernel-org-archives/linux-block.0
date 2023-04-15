Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1E8C77B70
	for <linux-block@archiver.kernel.org>; Sat, 15 Apr 2023 20:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjDOUlA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Apr 2023 16:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDOUk7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2023 16:40:59 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A48DC9
        for <linux-block@vger.kernel.org>; Sat, 15 Apr 2023 13:40:58 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-5e7534b6736so3860716d6.0
        for <linux-block@vger.kernel.org>; Sat, 15 Apr 2023 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681591258; x=1684183258;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5ZpJOS2H9PgGp4Q72WdTfSs9gPQF5dEYfpY40h9OUQ=;
        b=UzU//76cztdU1LgexNLanS+PonvEY1gfbmf2XiwBHWabM0B+HR+5mkKYMsJklwCCn/
         D5bcRCSYS143FhZdjgcNigSfttd9A+nUNaSO8oI9FcIbEQcL+e5M6JLXwQJ36h5j4cWw
         9Y87Z871/OiG5GP0uPnJxCGb0J1Q3je9mvsT5eLZICyaQaXJFk38RCH6wZI6fMyCoA03
         ig/CUVoT4ZH8CnNByrhBkIojoU+mZC+T/3OV1nMOMHShB6czLciDHtzBzG6WajheDuS0
         mpGwt9J6iuTLkiRY8Nv8/67dpQ4L1Q51NpHQLMMqBDZGgRUPlFtGugqsj/pi8PLZ9Rgm
         NeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681591258; x=1684183258;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5ZpJOS2H9PgGp4Q72WdTfSs9gPQF5dEYfpY40h9OUQ=;
        b=Gpym6azClwCNWfRND9y7iiBv+1RH3CbEG/J+S1+8cHeI/822m0ZN3rdLDA8lWB8HQ2
         GZTjCg2vbwmot81xOT1CdbQaxaO13zv3XgAjX3+WsIJBVI04Wown4NlOMjkpH7q5P9pi
         K6NaAE/UFm5Gj/QeVgWtb23g84mu0kSuGzITSJWwRzRLMc2yk2174EZ0v9X/p3Cb+2dH
         hooitFhU7zY9q42qyPt0DYV64N3wzvEpIGoOiPQBE63EB+4n/zSe2K2WcVIdKEU4n4+S
         A6vXPwcOah6hLF8NUGg3KUBA4vhBvXAOVJqBBrtF3g3Dl/u5zDIZklc9deDHpyNiqJZL
         zGpw==
X-Gm-Message-State: AAQBX9d7ZyC4YPei46A5lY6fIwnPOTNjk9WLb05R7+Q9hKRFMDevqQPk
        gSzmaLXcF9k7TNimUGet2/vHvrM4yZYzUTECndw=
X-Google-Smtp-Source: AKy350b7Jgq/iFYYGf1L3SXkiJAspR6o8DYiL85urxLnUkV+LsBU0p8W38LeUr7ZJa9KfcGW8yLuuw==
X-Received: by 2002:a05:6214:3011:b0:5ef:5132:7ad7 with SMTP id ke17-20020a056214301100b005ef51327ad7mr9930130qvb.2.1681591257782;
        Sat, 15 Apr 2023 13:40:57 -0700 (PDT)
Received: from [127.0.0.1] ([216.250.210.6])
        by smtp.gmail.com with ESMTPSA id pp26-20020a056214139a00b005dd8b934571sm1996244qvb.9.2023.04.15.13.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 13:40:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     lkp@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, shinichiro.kawasaki@wdc.com,
        chaitanyak@nvidia.com, akpm@linux-foundation.org, hch@infradead.org
In-Reply-To: <20230415125705.180426-1-akinobu.mita@gmail.com>
References: <202304150025.K0hczLR4-lkp@intel.com>
 <20230415125705.180426-1-akinobu.mita@gmail.com>
Subject: Re: [PATCH -block] fault-inject: fix build error when
 FAULT_INJECTION_CONFIGFS=y and CONFIGFS_FS=m
Message-Id: <168159125392.9478.18069985091201670556.b4-ty@kernel.dk>
Date:   Sat, 15 Apr 2023 14:40:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 15 Apr 2023 21:57:05 +0900, Akinobu Mita wrote:
> This fixes a build error when CONFIG_FAULT_INJECTION_CONFIGFS=y and
> CONFIG_CONFIGFS_FS=m.
> 
> Since the fault-injection library cannot built as a module, avoid building
> configfs as a module.
> 
> 
> [...]

Applied, thanks!

[1/1] fault-inject: fix build error when FAULT_INJECTION_CONFIGFS=y and CONFIGFS_FS=m
      commit: 5347c9321845e5a94be19ea951746d4f2b8b194f

Best regards,
-- 
Jens Axboe



