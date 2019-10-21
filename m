Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76721CA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 19:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C8A2086D
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 19:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="pvmc6TmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfJUT4c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:56:32 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:44782 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJUT4c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 15:56:32 -0400
Received: by mail-qk1-f182.google.com with SMTP id u22so13908346qkk.11
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6SOd1NDUElyNNC6sJJPfBCinbO2wmPqMmYAhpTG4xqw=;
        b=pvmc6TmTN5dT9XNou294j52FGLXmMnB5WKKsuY2uMGNP0+grDGJu6trFTAAQRog3vF
         nlKsPX+mhR6uUMrQ/RHKEMlk7aEdszv/1+h3DilR0kK9Pilip9yVyABu20fY3p1oBJ21
         7sqSaXljpuv8hljeHPOfSjGp2ryau3D2zw3jAxGnrKNwjaHfhiBhSIYZ6VdDLfG+oGFj
         a5fXkI7MCsfnpD+bthXvEGw4k0UdftUteZDp1zwyT9vUnxz7pBC/Zm/elXsG5GpUW42f
         botkcA9Ypb6/8BZhNk3wHk4oHC+bzOovQi9gMs2HAy1sONJ2098p7sXIiIQZdVATO5ch
         WkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6SOd1NDUElyNNC6sJJPfBCinbO2wmPqMmYAhpTG4xqw=;
        b=PWgTt/lLgJvExjPoozFAISbQfnENZRhn7AOVLQdOL+PjWUK4LKjjnN5EOYZqlbmZfH
         oPYtB/S8A1LXn0r0Qkh20J1h2b/8ve2T2R2WwIKGSq05D54zi6Q0+gNcaYI4RSTKXUoD
         Nq53EykZVYCSrTXytfwPxD/KJzBYszUJy/BHYJN+xCoLAdTt+hop2VhbbcIC6EdgQSaB
         hoi6c4sHRcOprRei9zaM6JMvY85B65pN7vKPq1CARk3azm6XxLdWFP742R4wDZu2fQ73
         EDm26+qigDtMVDlVdTppSuDGZq34BamS/yXUwIE+zBFvNljTuFAAOw3JZ46GbncufBYu
         G/kw==
X-Gm-Message-State: APjAAAX4FGgrBUhNiUxoaznM3LgpliaIIC8IKZ68HwC/aaONIhGOsGQE
        X6IwZ3n/vCAQlB7fEvpoU1TilA==
X-Google-Smtp-Source: APXvYqzaxQcGOVHl9VXYuOfzdWxu800rP2kr7RQ1pyQmWQ+NERVPplWudZN5XUoV3RSylCda3cg9hA==
X-Received: by 2002:a05:620a:526:: with SMTP id h6mr13491287qkh.213.1571687791017;
        Mon, 21 Oct 2019 12:56:31 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v141sm8174494qka.59.2019.10.21.12.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 12:56:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, nbd@other.debian.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, mchristi@redhat.com
Subject: [PATCH 0/2] fix double completion of timed out commands
Date:   Mon, 21 Oct 2019 15:56:26 -0400
Message-Id: <20191021195628.19849-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We noticed a problem where NBD sometimes double completes the same request when
things go wrong and we time out the request.  If the other side goes out to
lunch but happens to reply just as we're timing out the requests we can end up
with a double completion on the request.

We already keep track of the command status, we just need to make sure we
protect all cases where we set cmd->status with the cmd->lock, which is patch
#1.  Patch #2 is the fix for the problem, which catches the case where we race
with the timeout handler and the reply handler.  Thanks,

Josef

