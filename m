Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFB1C433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 11:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJDLLf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 07:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJDLLY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 07:11:24 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A9620BD7
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 04:11:20 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 294BAuLE002655;
        Tue, 4 Oct 2022 20:10:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Tue, 04 Oct 2022 20:10:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 294BAtVs002648
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Oct 2022 20:10:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <63e14e00-e877-cb5a-a69a-ff44bed8b5a5@I-love.SAKURA.ne.jp>
Date:   Tue, 4 Oct 2022 20:10:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: lockdep WARNING at blktests block/011
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <20221004104456.ik42oxynyujsu5vb@shindev>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20221004104456.ik42oxynyujsu5vb@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/10/04 19:44, Shinichiro Kawasaki wrote:
> Any comment on this patch will be appreciated. If this action approach is ok,
> I'll post as a formal patch for review.

I don't want you to make such change.

I saw a case where real deadlock was hidden by lockdep_set_novalidate_class().

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=62ebaf2f9261cd2367ae928a39343fcdbfe9f877
  https://groups.google.com/g/syzkaller-bugs/c/Uj9LqEUCwac/m/BhdTjWhNAQAJ

In general, this kind of deadlock possibility had better be addressed by bringing
problematic locks out of cancel{,_delayed}_work_sync() section.

  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=a91b750fd6629354460282bbf5146c01b05c4859

