Return-Path: <SRS0=4Sb2=2K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F39CC43603
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 12:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B9D2467F
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 12:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfLTMjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:39:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:47296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfLTMjg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Dec 2019 07:39:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9110AE47;
        Fri, 20 Dec 2019 12:39:34 +0000 (UTC)
Subject: Re: [PATCH] xen/blkfront: Adjust indentation in xlvbd_alloc_gendisk
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20191209201444.33243-1-natechancellor@gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <f915e97e-e395-7ef5-0971-1b6088cc4a6a@suse.com>
Date:   Fri, 20 Dec 2019 13:39:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209201444.33243-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09.12.19 21:14, Nathan Chancellor wrote:
> Clang warns:
> 
> ../drivers/block/xen-blkfront.c:1117:4: warning: misleading indentation;
> statement is not part of the previous 'if' [-Wmisleading-indentation]
>                  nr_parts = PARTS_PER_DISK;
>                  ^
> ../drivers/block/xen-blkfront.c:1115:3: note: previous statement is here
>                  if (err)
>                  ^
> 
> This is because there is a space at the beginning of this line; remove
> it so that the indentation is consistent according to the Linux kernel
> coding style and clang no longer warns.
> 
> While we are here, the previous line has some trailing whitespace; clean
> that up as well.
> 
> Fixes: c80a420995e7 ("xen-blkfront: handle Xen major numbers other than XENVBD")
> Link: https://github.com/ClangBuiltLinux/linux/issues/791
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Pushed to xen/tip.git for-linus-5.5b


Juergen
