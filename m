Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DEDCDB474
	for <linux-block@archiver.kernel.org>; Tue, 17 Oct 2023 15:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbjJQPYp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 11:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344336AbjJQPYo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 11:24:44 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B3BB0
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 08:24:43 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7a2874d2820so72783039f.1
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697556282; x=1698161082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFftDA/PClYULtpgugCLARTSXADqSLXzM0MPRZe4YDw=;
        b=IzQwHaTv3/cMVRdKyCg0GmKAEsLgWS8TPd50xI0++W6AGT2fVZIRx6lvHsgSmWWzxU
         cyjnRAJF4OOE4XV4saq9EXRBNliPiw043b/lPspWo/nqmYSRLcvS7aiWSv7Ct9bACY5v
         qt5kOUiWJzC6WwO7dtuEa7uqDtjJlQggxP0lQZGhEwBHZMap4d48MWFhLkPPfacYRw1l
         KZgivb3gImyY0uNfxAPgDY2FUKsJ0eh+hWPJY4DiksE8o+YGM4fiNgbU/SmH2J1snAwI
         FEV59fniliSA1TtjYnpYxE9y74y43I3uimIMzDMW7LgFf/j7ZyxZ0OaRrTxUYhrUe+/l
         Yqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556282; x=1698161082;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFftDA/PClYULtpgugCLARTSXADqSLXzM0MPRZe4YDw=;
        b=CRzedOr+wyssgkimyiURX9ieZrMyebjz3FAkGyQAAKUq91SxF+jkkqiVF2yODW+V/8
         gT7B+FkHg27Hg0DEsLvX2mGmfXuQCOZjplJHxKoQ8NF00Ik7logu4EQc3/iJa1tfrloa
         0a8w2A1cllm+STFWTGm2RdNcyYfomrJlV3JPJoAoI1vJ553dY0+D+SldaaY986gz+IE4
         NpFSg6iIY6/eZQkWqRZzKBA+aDtzARbypUTWF03zLduiijAm8n7kGNdEyt4sPVnVfagm
         CBMk6rpoAAPq8Ay+jn0zmeGZLKv1eX/eQsQ6Z6m4E01jVpAWuv7xNp8HW+TXJkAkvkED
         rmXQ==
X-Gm-Message-State: AOJu0Ywb7sfoeJpoIFvjD0axKf63/gxiD9+I2Zuzfn44BxXoLuirQQLv
        HpxVFMMUx3RWieUtvA7EXNnNRs8JVXlx9MRKGLR2rQ==
X-Google-Smtp-Source: AGHT+IGqBvcX191cb5ydEBlPiyHzQBCO3yoc5cODSSSY5HWvi4n3qf9AgqtcQgec9s2vfbGSW3Wn/A==
X-Received: by 2002:a05:6602:340f:b0:790:958e:a667 with SMTP id n15-20020a056602340f00b00790958ea667mr3377419ioz.2.1697556282564;
        Tue, 17 Oct 2023 08:24:42 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 10-20020a5d9c0a000000b0079199e52035sm481347ioe.52.2023.10.17.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:24:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, gjoyce@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, akpm@linux-foundation.org,
        ndesaulniers@google.com, nathan@kernel.org, jarkko@kernel.org,
        okozina@redhat.com
In-Reply-To: <20231004201957.1451669-1-gjoyce@linux.vnet.ibm.com>
References: <20231004201957.1451669-1-gjoyce@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 0/3] generic and PowerPC SED Opal keystore
Message-Id: <169755628159.2220568.17278716462071055905.b4-ty@kernel.dk>
Date:   Tue, 17 Oct 2023 09:24:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 04 Oct 2023 15:19:54 -0500, gjoyce@linux.vnet.ibm.com wrote:
> This patchset has gone through numerous rounds of review and
> all comments/suggetions have been addressed. The reviews have
> covered all relevant areas including reviews by block and keyring
> developers as well as the SED Opal maintainer.
> 
> TCG SED Opal is a specification from The Trusted Computing Group
> that allows self encrypting storage devices (SED) to be locked at
> power on and require an authentication key to unlock the drive.
> 
> [...]

Applied, thanks!

[1/3] block:sed-opal: SED Opal keystore
      commit: 96ff37ceb203426b1bcebbae42399686110b0130
[2/3] block: sed-opal: keystore access for SED Opal keys
      commit: 5dd339722f5f612f349b068e8da6d6710fd0e460
[3/3] powerpc/pseries: PLPKS SED Opal keystore support
      commit: ec8cf230ceccfcc2bd29990c2902be168a92dee4

Best regards,
-- 
Jens Axboe



