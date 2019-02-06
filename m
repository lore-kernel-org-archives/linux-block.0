Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1073FC282C2
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 17:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77FA2175B
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 17:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfBFRGT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:06:19 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:28683 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfBFRGS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Feb 2019 12:06:18 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 1E51413F8F6;
        Wed,  6 Feb 2019 18:05:34 +0100 (CET)
Subject: Re: dd hangs when reading large partitions
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
 <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
 <b3910158-83d6-21fe-1606-33e88912404a@oracle.com>
 <d082bdee-62e5-d470-b63b-196c0fe3b9fb@free.fr>
 <5132e41b-cb1a-5b81-4a72-37d0f9ea4bb9@oracle.com>
 <7bd8b010-bf0c-ad64-f927-2d2187a18d0b@free.fr>
Message-ID: <0cfe1ed2-41e1-66a4-8d98-ebc0d9645d21@free.fr>
Date:   Wed, 6 Feb 2019 18:05:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7bd8b010-bf0c-ad64-f927-2d2187a18d0b@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/02/2019 17:16, Marc Gonzalez wrote:

> # dd if=/dev/sde of=/dev/null bs=1M & while true; do echo l > /proc/sysrq-trigger; sleep 1; done
> https://pastebin.ubuntu.com/p/Sx4hXRbHby/
> 
> What other information can I provide to help debug this issue?

# dd if=/dev/sde of=/dev/null bs=1M & while true; do echo m > /proc/sysrq-trigger; echo; sleep 1; done
https://pastebin.ubuntu.com/p/tXTCK3Jypn/

Here are the first and last Mem-Info reports:
(Identical fields removed)

active_anon:1449 inactive_anon:3417 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 slab_reclaimable:1309 slab_unreclaimable:2174
 mapped:465 shmem:4797 pagetables:14 bounce:0
 free:979014 free_pcp:2068 free_cma:0
Node 0 active_anon:5960kB inactive_anon:13668kB active_file:0kB inactive_file:656kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:2188kB dirty:0kB writeback:0kB shmem:19188kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
DMA32 free:1972788kB min:3956kB low:5924kB high:7892kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:2045952kB managed:1974524kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:1480kB local_pcp:1480kB free_cma:0kB
Normal free:1936864kB min:3992kB low:5976kB high:7960kB active_anon:6956kB inactive_anon:13668kB active_file:0kB inactive_file:5584kB unevictable:0kB writepending:0kB present:2068224kB managed:1986952kB mlocked:0kB kernel_stack:1456kB pagetables:76kB bounce:0kB free_pcp:6408kB local_pcp:612kB free_cma:0kB
DMA32: 1*4kB (M) 4*8kB (M) 3*16kB (M) 3*32kB (M) 4*64kB (M) 3*128kB (M) 5*256kB (UM) 5*512kB (UM) 6*1024kB (UM) 6*2048kB (UM) 476*4096kB (M) = 1972788kB
Normal: 2*4kB (E) 4*8kB (ME) 1*16kB (E) 2*32kB (ME) 2*64kB (ME) 2*128kB (UM) 0*256kB 3*512kB (UME) 1*1024kB (E) 1*2048kB (M) 471*4096kB (M) = 1934328kB
6974 total pagecache pages

active_anon:1762 inactive_anon:3403 isolated_anon:0
 active_file:0 inactive_file:949699 isolated_file:0
 slab_reclaimable:3465 slab_unreclaimable:2220
 mapped:591 shmem:4798 pagetables:19 bounce:0
 free:26601 free_pcp:2250 free_cma:0
Node 0 active_anon:7048kB inactive_anon:13612kB active_file:0kB inactive_file:3798796kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:2364kB dirty:0kB writeback:0kB shmem:19192kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
DMA32 free:100488kB min:3956kB low:5924kB high:7892kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:1866424kB unevictable:0kB writepending:0kB present:2045952kB managed:1974524kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:2844kB local_pcp:1172kB free_cma:0kB
Normal free:5916kB min:3992kB low:5976kB high:7960kB active_anon:7048kB inactive_anon:13612kB active_file:0kB inactive_file:1932372kB unevictable:0kB writepending:0kB present:2068224kB managed:1986952kB mlocked:0kB kernel_stack:1472kB pagetables:76kB bounce:0kB free_pcp:6156kB local_pcp:516kB free_cma:0kB
DMA32: 2*4kB (UM) 2*8kB (M) 1*16kB (U) 1*32kB (U) 5*64kB (M) 6*128kB (UME) 6*256kB (UME) 5*512kB (ME) 7*1024kB (UME) 7*2048kB (UME) 18*4096kB (M) = 100488kB
Normal: 3*4kB (ME) 4*8kB (UE) 3*16kB (UME) 0*32kB 1*64kB (U) 1*128kB (M) 0*256kB 3*512kB (UME) 2*1024kB (UE) 1*2048kB (M) 0*4096kB = 5916kB
954552 total pagecache pages


'inactive_file' grows from 0 to 949699
'free' shrinks from 979014 to 26601 (probably 0 by the time the system hangs)
'total pagecache pages' grows from 6974 to 954552

Where are "pagecache pages" allocated? and freed?

Regards.
