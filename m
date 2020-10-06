Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F33C41604
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 19:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A711206CB
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 19:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgJFTmb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgJFTmb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 15:42:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3783AC061755
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 12:42:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E855127E959
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        kernel@collabora.com, Omar Sandoval <osandov@fb.com>
Subject: Re: [RESEND PATCH v2] block: Consider only dispatched requests for inflight statistic
Organization: Collabora
References: <20201006191509.2482378-1-krisman@collabora.com>
        <20201006192038.2484672-1-krisman@collabora.com>
        <8e53dcca-bd5f-4b81-cf73-d905f2c36dcd@kernel.dk>
        <874kn7no97.fsf@collabora.com>
        <b2126313-066a-11f0-32bd-8cd407fce3f2@kernel.dk>
Date:   Tue, 06 Oct 2020 15:42:24 -0400
In-Reply-To: <b2126313-066a-11f0-32bd-8cd407fce3f2@kernel.dk> (Jens Axboe's
        message of "Tue, 6 Oct 2020 13:35:21 -0600")
Message-ID: <87zh4zm99b.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 10/6/20 1:33 PM, Gabriel Krisman Bertazi wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>>> On 10/6/20 1:20 PM, Gabriel Krisman Bertazi wrote:
>>>>
>>>> Oops, I have no idea what happened, but something ate the hunk at the
>>>> last submission.  My apologies.  Please find it below.
>>>
>>> Care to just resend a fixed up one? Saves me the time from fixing
>>> things up.
>> 
>> hm, the first submission had an empty patch and the email you quoted had
>> the entire fixed patch ready to apply with scissors.  It should be good
>> to apply it, I think.  Or, what do you mean?
>
> The point is that I need to manually fiddle with it.

Done, sorry for the noise.  The v3 should apply on top of your for-next
branch cleanly.

-- 
Gabriel Krisman Bertazi
