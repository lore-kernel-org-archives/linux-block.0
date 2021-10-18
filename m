Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA01DC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F37160F56
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhJRMdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJRMda (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 08:33:30 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06153C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:31:20 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id j8so14635746ila.11
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xu/b89xU8oruQsCoSmG1FQ+yEk+vQzZ9pj6i4qjZ1/8=;
        b=oG5n5xA6P5Ge4GUsjuFXaGJTjy8/NjNY8yV+APt6DPYUWHEYYgjfeSJS/T6fF3gHJF
         fVBMkiSW9hHzxRMTSwsgAuZujgzfp0fBAMBGN8RnpSW7H8MlypqiGNdV0SDSr1PjLCKR
         DAkDeV+sj1bw0zNFVVtpBSd2ktzJhbNn738tSFBJI0nBSuaauS6KciLlRcQQq0D1W1nC
         5kz65IbMwUYg9DADhCgfliM0prECxj37seTaf/qeYTN6RzH3hr99dz+skhv70bFDYuis
         LkSewN2v2j2LcmBpbE+PP/NACPXuFaFxbO6mY1bYydz1X2FqsRXQk68bffnEL+84A+hx
         EMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xu/b89xU8oruQsCoSmG1FQ+yEk+vQzZ9pj6i4qjZ1/8=;
        b=TY3G+Uil4k7UF+haPbP24PbUs+Pra9PH/ms7LPf5wnUVE1xwbNkhaYB6ZOcKDQPQ2D
         LqQZfmJs11K3CH0aj8711lMVMSjPBER1uu3T0SnGVhCvNv+DuLy20754CozbN/6Y90PS
         O2Q7Zz9DJmJk8qgp5k2y/L/rNUmVa3hnAkgWyvojXzbdwVTW1y9jTelCmiOlaa1Botau
         KkUMFJgrre/pK12LJcKDW92KHdDGDaxgWziy7e/Xr601aj1ZwVuEQ3yTM/4B7oFarZMo
         865Q3Gyc9Uek8zrZpUDYPUA6+73tSdaRQ7tSo1+TrOZKc+I+NotAgL4BFaDo5e7aSwL6
         1YiQ==
X-Gm-Message-State: AOAM530nxdH6irNeQgTTrqUH2sDtT5/ZlxotE4M8arQ2jYeGdKv63pqF
        J5F9MsHYY/8aEQdCqiue2VX9dJq1mwMjnw==
X-Google-Smtp-Source: ABdhPJz7dg7y+zQ2o6cgj5MGtrhY1qDhuJh0AAntwS0qHZc+0/UoGD1XcXmplBvMfLuxDXrfiQVUPA==
X-Received: by 2002:a05:6e02:12cc:: with SMTP id i12mr5216588ilm.322.1634560279179;
        Mon, 18 Oct 2021 05:31:19 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f13sm69504ilu.82.2021.10.18.05.31.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 05:31:18 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: Block trees rebased
Message-ID: <795ab0ff-dd7d-d225-e42a-04878bd4d8d1@kernel.dk>
Date:   Mon, 18 Oct 2021 06:31:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Just a heads-up that I've rebased the 5.16 block trees, mainly to avoid
a bunch of conflicts with the bdi lifetime fixes that went into -rc6, but
also to get rid of a silly post-merge branch that we ended up having.

-- 
Jens Axboe

