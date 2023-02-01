Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B75C05027
	for <linux-block@archiver.kernel.org>; Wed,  1 Feb 2023 15:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjBAPR3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 10:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjBAPRQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 10:17:16 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A0DA5CC
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 07:16:38 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id w24so3693122iow.13
        for <linux-block@vger.kernel.org>; Wed, 01 Feb 2023 07:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsscBhiIjk6r0I7QJUTwjInitjJEZw8Azs6oUF5X1Yo=;
        b=iFEi7B9xbJjiJS9GxyQQkSWa4/JK9AIvPdgGkuU65hyv8dmdwrPgVD9y5BDaNxi4Ek
         vIh/EO6c6JTsxeYbuufwYQJC8j1UYkgIP8FXyMeAa1hyi+y1a9DIyJBxWKq99Fg8XDAU
         2cVWcpc3hYO3+SoypbiPh3j1VYYzE3TT4qS8frZt/NdVgkHwS+uUMvWgRSiEHD0IRnPx
         yLDnQM4lU/VdXTEhNqVpptKDejwG9UGG8Gfkjh63MFAv7Vqyl2dmRRr6NESH1qybvD37
         rkWws2BchdVQckcsW3gtlegKrictcWzMchKc28peWWBwrWSyg9gDO0anp4bwnBAMxzIA
         Mqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsscBhiIjk6r0I7QJUTwjInitjJEZw8Azs6oUF5X1Yo=;
        b=69h1gez5PPTcN1J2luf5U9Ec1jeaY1BZ30ZFHUuus7YkoE6M9QUCp7G9K+/dQdCqT1
         EEM0xDOJC7q4hUWK+1GJwgJM4nwXRhXla3HuuK+betaaUKaXimB8W97BmFHnOUQvvtjv
         3TE3KpCmL2GvCaRVn/+cgs7wQWOykpEMWzPPKTWIrusA4Mb4cxMkWm/8fAmHld2fGa7v
         XhwrNSFn7p76now/cuw32cPkEha60QCFFTx7HjvShG2H1+JGNNMWkte1MsoCo1b5bJic
         Dhkw1fS5Dpq1nmJ1AZbkFUvphv/66r7NNPqgD736rReo/FEu4vCqTxx7CKxqMaDPW/TV
         jxew==
X-Gm-Message-State: AO0yUKW2bAzVu3qK3d8QsUFe0/VktkQyEsyo4STuV+2SgmjYBhXpZYMP
        HFdP1kLdPVYypMaGVKllxJu1DLdzoeu/mMVu
X-Google-Smtp-Source: AK7set+o/gTjQRYF6QAMgH6aEU/fKneX94a5yuV5PbP0UVCNLVrnVRQXi/6tCTWHaX6Uyycl/llCMw==
X-Received: by 2002:a5d:954b:0:b0:70a:9fce:853c with SMTP id a11-20020a5d954b000000b0070a9fce853cmr1532265ios.2.1675264594915;
        Wed, 01 Feb 2023 07:16:34 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ay24-20020a056638411800b003a956e9c7dcsm3039127jab.44.2023.02.01.07.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:16:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20230130211347.832110-1-bvanassche@acm.org>
References: <20230130211347.832110-1-bvanassche@acm.org>
Subject: Re: [PATCH] loop: Improve the hw_queue_depth kernel module
 parameter implementation
Message-Id: <167526459414.10042.16237499913551289493.b4-ty@kernel.dk>
Date:   Wed, 01 Feb 2023 08:16:34 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 30 Jan 2023 13:13:47 -0800, Bart Van Assche wrote:
> Make the following minor changes which were reported by colleagues
> while reviewing this code:
> - Remove the parentheses from around the LOOP_DEFAULT_HW_Q_DEPTH
>   definition since these are superfluous.
> - Accept other number formats than decimal, e.g. hexadecimal.
> - Do not set hw_queue_depth to an out-of-range value, even if that value
>   won't be used.
> - Use the LOOP_DEFAULT_HW_Q_DEPTH macro in the kernel module parameter
>   description to prevent that the description gets out of sync.
> 
> [...]

Applied, thanks!

[1/1] loop: Improve the hw_queue_depth kernel module parameter implementation
      commit: e152a05fa054170c05f1d5e04e93e2e75ea11405

Best regards,
-- 
Jens Axboe



