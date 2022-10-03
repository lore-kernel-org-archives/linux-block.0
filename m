Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDA7C433FE
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 23:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJCXCq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 19:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJCXCp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 19:02:45 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998342CDFE
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 16:02:44 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g23so7271724qtu.2
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6VsJp9sS4qNsji9YfkYRRlTBglgWqR5JdV0cIEyNwGY=;
        b=cDtPmqgES0aE0aaU/VNCeB7zPh9/2Z8gBJnrHAQ9Irgc6sc3C6VdJM+aMr6FQlH7T8
         C7yigcPeMjnwk4RiPQWmTszf2st84DrAmO8CbqwK6b/6aDMzB0//SVXDN2YpxnhVu0pu
         o6yfzwnc5cFFcx5HS9OgCimzl8aJRM9ig/ECU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6VsJp9sS4qNsji9YfkYRRlTBglgWqR5JdV0cIEyNwGY=;
        b=zYFnVCrwMGkDpERz8+jnhDBGZaXUjwd8JDNJ8a44AgRdm+akaTn7tpUbsFjySE7LZT
         Zthxo6eYOBYBbq/V16wUngqcJjxzOoe1QkPFHUxlrdd09EVR9/l92c/9KY4X5c9yXaKX
         HXwV84daIAXZwVpVRbQv8zvShuRHlmNtKQYway5KyVebNfe5RFrUKystiiAKmt+4hSm0
         ylxRWUipVDcO+RuLsTu4UNLYa46XUWom20Ao2OJF2FzJFzIyB5CusDonrt//PAqp4ypT
         INEYZ2nM2TgmoG2kGxLWRU81iKdf3J+9Vdfb1LQft0vLmZK1ugAXkf1i1xckJ5dlDjyq
         DmDw==
X-Gm-Message-State: ACrzQf34+2Ji8HkDzRu6fZrnXW4gWU7dfUbpKzw6oP8Z7zbnxga7u27E
        WiJ1LKv/hPnC5ZMcdqqvTsCMbZ+rsT2Bjw==
X-Google-Smtp-Source: AMsMyM4RlzqjkqsHO3NkDDwlqcG7vvMXQi5olx2Dxb1X57214T8lRH+l4y5KIVpq/CMKrxRh/L83SQ==
X-Received: by 2002:ac8:5801:0:b0:35c:dc46:1a50 with SMTP id g1-20020ac85801000000b0035cdc461a50mr17510507qtg.216.1664838163633;
        Mon, 03 Oct 2022 16:02:43 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id 85-20020a370758000000b006ceb8f36302sm11657496qkh.71.2022.10.03.16.02.42
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 16:02:42 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id d1so7829878qvs.0
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 16:02:42 -0700 (PDT)
X-Received: by 2002:ad4:5baf:0:b0:4b1:7a87:4f6c with SMTP id
 15-20020ad45baf000000b004b17a874f6cmr9802897qvq.117.1664838162390; Mon, 03
 Oct 2022 16:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220926220134.2633692-1-khazhy@google.com> <3362d316-0c86-ecaf-4422-d12ee115a2eb@nvidia.com>
In-Reply-To: <3362d316-0c86-ecaf-4422-d12ee115a2eb@nvidia.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Mon, 3 Oct 2022 16:02:31 -0700
X-Gmail-Original-Message-ID: <CACGdZYLrwi2a=0b0sEtjpsZptZxR_0jcNSckrrACcospuicYDA@mail.gmail.com>
Message-ID: <CACGdZYLrwi2a=0b0sEtjpsZptZxR_0jcNSckrrACcospuicYDA@mail.gmail.com>
Subject: Re: [PATCH] block: allow specifying default iosched in config
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Gentle ping now that the merge window is open :)
