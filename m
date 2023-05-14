Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA091C77B7F
	for <linux-block@archiver.kernel.org>; Sun, 14 May 2023 12:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjENMFi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 May 2023 08:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjENMFd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 May 2023 08:05:33 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9807D198B;
        Sun, 14 May 2023 05:05:32 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pyATg-0008Pv-5u; Sun, 14 May 2023 14:05:28 +0200
Message-ID: <efd48a80-dd07-4084-d61d-4e02c35a1300@leemhuis.info>
Date:   Sun, 14 May 2023 14:05:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Situation of CONFIG_BLK_WBT_MQ after commit b11d31ae01e6
 ("blk-wbt: remove unnecessary check in wbt_enable_default()")
Content-Language: en-US, de-DE
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAKXUXMzfKq_J9nKHGyr5P5rvUETY4B-fxoQD4sO+NYjFOfVtZA@mail.gmail.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAKXUXMzfKq_J9nKHGyr5P5rvUETY4B-fxoQD4sO+NYjFOfVtZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684065932;465f08d9;
X-HE-SMSGID: 1pyATg-0008Pv-5u
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 08.05.23 06:37, Lukas Bulwahn wrote:
> 
> The commit b11d31ae01e6 ("blk-wbt: remove unnecessary check in
> wbt_enable_default()") removes the only reference to the config
> BLK_WBT_MQ in the kernel tree.
> [...]

Thanks for the report. I know a fix is already in the works but to
ensure the issue doesn't fall through the cracks unnoticed, I'm adding
it to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced b11d31ae01e6
#regzbot title block/blk-wbt: wbt can't be disabled by default
#regzbot ignore-activity
#regzbot monitor:
https://lore.kernel.org/all/20230512093554.911753-2-yukuai1@huaweicloud.com/

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

