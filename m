Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAEEC43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 18:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbiFUSb0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiFUSbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 14:31:25 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC38245A6
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 11:31:24 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o73so10783006qke.7
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0NlM4xJVC+aQrSrJgSgq0lw3fSCtXD7f9PJ3WEW+snY=;
        b=T9DeH1tdcsY6/y90jaWZn9sBSMreY/6fYy5JfAnBkqFhi8U06WJsRV1yPwPdRoZhmb
         t1a4+QBP4IugIjOrKvkbhvnH9bKSZ1y7mmOjw4hKFa/bBGbqZwC4BgHvdvDtBy6qWu/S
         G/nYqb9MGVjH5blyIZbYwbKnXO4jnyjP7Ek07TvvEabDEMRt8BIC6AgfPopzcjS3LkKp
         5KVuRpCLtCHJyyAtI0ngnM82eaeZDfY2P/nzySkK5Nw9/xwitBevsp0m/hT0YMNF2u0r
         utQSWGq8Av6erTGkUfrH5RYPeYpN7WIEvc2U9Ti+awbRtU9X0C2QVHJq9HBH9uOZBIAZ
         nHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0NlM4xJVC+aQrSrJgSgq0lw3fSCtXD7f9PJ3WEW+snY=;
        b=UPwxKm21gRLWgXzHGyxLtZqyyjde4vob6T+4GTTPMEWiyzm8a3FLadvw6OpZQ57ISX
         aufYdFdLt9Vaz+djoypegIy9SbEsfQJ6E+3ZwctWq3djc/PnGw+x8+D4zen44jG8MbXb
         hMpHXBajV/K3JMkRR62vzELAUWhIzrw3thBtg8VQvzaIXIWYvjrd/vYRLffZHLXkeG7B
         AMjQDudr3FTbnLXnq3/adaKMFEXGBMKQWaruiZxfDyg5t+p4PG1r3XwIhCGW84UifmDF
         RjstZ9CoHTCm1RtlI/ziu0tcYV6a7Hi7hDjglh/3QIIZisS156n3yUg0XfS2BKa3Mtas
         bB0g==
X-Gm-Message-State: AJIora8DLZSmTgQb3zwlcTL/TnFJaaF9lwyByvXIcd34sJaKSpSB0xJ+
        czBIsMTLUCXoRBioEWe2a70GtE82Wm2+BnlF68kuRQ==
X-Google-Smtp-Source: AGRyM1s0ZNh6AJMrXbJKR18iOitLzcO1NyUz0Tk/gIvDUtjovASPYxds/P0hzU4wYhaZ7pEJgWzg3R9X4kmRhOCq/HQ=
X-Received: by 2002:a05:620a:9c4:b0:6a6:9c07:c243 with SMTP id
 y4-20020a05620a09c400b006a69c07c243mr21511010qky.783.1655836283892; Tue, 21
 Jun 2022 11:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220620202602.2805912-1-changyuanl@google.com> <f21b7a51-ccb0-b8dc-a48e-94a7a0f7e125@acm.org>
In-Reply-To: <f21b7a51-ccb0-b8dc-a48e-94a7a0f7e125@acm.org>
From:   Changyuan Lyu <changyuanl@google.com>
Date:   Tue, 21 Jun 2022 11:30:48 -0700
Message-ID: <CAGzOjsqoZ3CoogdsN23tAMMSoGbqXvhSXSiQiMbCf8gTuxtwDQ@mail.gmail.com>
Subject: Re: [PATCH] trace: events: scsi: Print driver_tag and scheduler_tag
 in SCSI trace
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rajat Jain <rajatja@google.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Vishakha Channapattan <vishakhavc@google.com>,
        Jolly Shah <jollys@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/20/2022 20:56, Bart Van Assche <bvanassche@acm.org> wrote:
> Despite the above comments, thanks for the detailed and very
> informative patch description.

Thanks for helping me improve the commit message. I fixed these
issues in v2.

Best,
Changyuan Lyu
