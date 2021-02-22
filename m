Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A4BC433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 18:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2CB64F00
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 18:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhBVST0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhBVSSP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 13:18:15 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF6C061574
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 10:17:34 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id x3so9948687qti.5
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 10:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=afQMezrHHZ/s/cFD66A7wjauGG6Mot8qzrIoVlp+Mjs=;
        b=DHrXj9tMDFBraxw7X4jINTU+CsW1tO9WZM8lqySA+3+QPTXgB75H65JRSLty4fkbc+
         grztx9O4Sd4IbLW6h05IGADg7dRhZAq2bBCyy7Zfs7aQ+pDlqpsvxmPjYAcke8FDpbbE
         DrBD29lvXrFQ2RY+nI0Me/MkOsUj+CMPIKmfgRUcJnNCFpq87TDC4MX0vXkF4LyBpxmp
         UzN7sltqmxCPCr5gdMK6dCtZTcPhHf01RKYmm1pg2neUHj1WcyVfgTRbnKw9MfszNlOz
         s386jdT7k3hR3+I5Pnz6gQNedrI7syzZSe7m/TSUilko46VXzXxU8erXuXGuYb1ThJ7D
         1Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=afQMezrHHZ/s/cFD66A7wjauGG6Mot8qzrIoVlp+Mjs=;
        b=i5XAln+IEDm2gYd0Nyu0e4sFTw3UkIrwXueFdLVsk+8J5jmacBm2IP81ohPhS9RTTN
         tH8E0MruEIaG/wZub85r1ScHi1GNOVOpxuFNsr0bZuKml4ojBp+SCrwf5LHYQicTuV0t
         lmyLDFxIFR99ik38YZmRw/OMMHtW5z5tKMBPTfpb1p9NrES+snShOsz2ZuY7daid2SRR
         KifeE5PxvL5uKxKI136TYgpBeEeYYXHrscARPKaOqU/cYZaltuVCDx6qZgM6kmSty6sG
         hAQO4VxE2cpMT4reXVgbSD9W0/tOAYTxF+qXYcBv31AoBV+lKcwwwFKIXE//NLhSAT1f
         oG+Q==
X-Gm-Message-State: AOAM531b1MR4TmPKfaV/mCVjDbASl9ErjUnTPYqSkx/S4mVKmw+KUXRh
        tzjZvYKXEKVv5qj8DaUdfsHCDw==
X-Google-Smtp-Source: ABdhPJxL4io7CWfbZu6770iiQG2aFziBpKkjjFDeAcumIDrZ4paU3pVZ02Fog3B5IfLb8FGSlIAOyw==
X-Received: by 2002:ac8:4c8e:: with SMTP id j14mr21698071qtv.92.1614017853927;
        Mon, 22 Feb 2021 10:17:33 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o194sm12816499qke.101.2021.02.22.10.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 10:17:33 -0800 (PST)
Subject: Re: KASAN: use-after-free Read in nbd_genl_connect
To:     syzbot <syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000bda69205bbe88a09@google.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <49ac93fc-57b0-1f94-c43e-f9ab9a3913af@toxicpanda.com>
Date:   Mon, 22 Feb 2021 13:17:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <000000000000bda69205bbe88a09@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 3:25 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f40ddce8 Linux 5.11
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=179e8d22d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e53d04227c52a0df
> dashboard link: https://syzkaller.appspot.com/bug?extid=429d3f82d757c211bff3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d190cad00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dc8a82d00000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1128ae60d00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1328ae60d00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1528ae60d00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com
> 

#syz test:  git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git 
nbd-kasan-fix
