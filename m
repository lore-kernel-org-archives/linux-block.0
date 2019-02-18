Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE4C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 12:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4968921773
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 12:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfBRMh3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:37:29 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:35794 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbfBRMh2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 07:37:28 -0500
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
References: <fb63a4d0-d124-21c8-7395-90b34b57c85a@linux.ee>
 <1c26eab4-3277-9066-5dce-6734ca9abb96@linux.ee>
 <076b8b72-fab0-ea98-f32f-f48949585f9d@linux.ee>
 <20190216174536.GC23000@mit.edu>
 <e175b885-082a-97c1-a0be-999040a06443@linux.ee>
 <20190218120209.GC20919@quack2.suse.cz>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <7ffcadd5-47b3-e44a-bd18-7e9f1a636f8d@linux.ee>
Date:   Mon, 18 Feb 2019 14:37:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190218120209.GC20919@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Hum, weird. I have hard time understanding how that change could be causing
> fs corruption on Aplha but OTOH it is not completely unthinkable. With this
> commit we may migrate some block device pages we were not able to migrate
> previously and that could be causing some unexpected issue. I'll look into
> this.

To make things more interesting, it does not happen on any alpha but only one subarch
so far: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1889207.html
is my original bug report.

-- 
Meelis Roos <mroos@linux.ee>
