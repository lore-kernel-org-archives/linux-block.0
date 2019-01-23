Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B754C282C4
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 03:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A2D20811
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 03:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mqW1uxy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfAWDIr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:08:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34550 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfAWDIr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 22:08:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0N33r0B138200;
        Wed, 23 Jan 2019 03:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=b1FNE4Kz2PBzImoKrsJ2Y2bEuDeNiK2w6mprV5xpAOg=;
 b=mqW1uxy+v9QA9a9Uakx/ONCO+tUv/prOu5zWiGviP2b8WMTPhspui5tqqQQMKNEFSbFo
 PJErqrmEHcA9VNNkoPkdQITbAh8/Qeav69Ctd26OxvslMXHZ2s2YquSOuondDSIp2tQm
 26xdlBjNig5xW4vzmTlJ0JsemVik6WG1c+ikSo0lQ18I5g1xObCYHPt+YfSYGzdtCj02
 OOymVNyBo9aIDTFRKiQZJa4cGiXmydmxHHvI0Vdtu+VmhKi7/fvHpbqEYgSNGkFjUlYh
 YSl4aNIhsglF16TE3FsLR3txSN/OWTHv+AiRfhyBE6EApMndAmwGUe9knXlv/6c5LaQF HA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2q3vhrq5p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 03:08:28 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0N38RZn011782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 03:08:27 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0N38OkM022078;
        Wed, 23 Jan 2019 03:08:24 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jan 2019 19:08:24 -0800
Subject: Re: dd hangs when reading large partitions
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
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
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <5132e41b-cb1a-5b81-4a72-37d0f9ea4bb9@oracle.com>
Date:   Wed, 23 Jan 2019 11:10:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d082bdee-62e5-d470-b63b-196c0fe3b9fb@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230023
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/22/19 6:59 PM, Marc Gonzalez wrote:
> On 22/01/2019 04:12, Jianchao Wang wrote:
> 
>> On 1/21/19 11:22 PM, Marc Gonzalez wrote:
>>
>>> Well, now we know for sure that the clk_scaling_lock is a red herring.
>>> I applied the patch below, and still the system locked up:
>>>
>>> # dd if=/dev/sde of=/dev/null bs=1M status=progress
>>> 3892314112 bytes (3.9 GB, 3.6 GiB) copied, 50.0042 s, 77.8 MB/s
>>>
>>> I can't seem to get the RCU stall warning anymore. How can I get
>>> to the bottom of this issue?
>> Can you detail the system 'locked up' ?
>> dd hangs there ? any hung task warning log ?
>> hang forever or just hang for a relatively long time.
> The system is an arm64 dev board (APQ8098 MEDIABOX) with 4GB RAM and 64 GB UFS.
> USB, SDHC, PCIe, SATA, Ethernet are not functional yet (so much work ahead).
> All I have is a single serial console.
> When the shell hangs, I lose access to the system altogether.
> SysRq is not implemented either. I am blind once the shell locks up.
> The system has been frozen for 15 hours, I think that qualifies as 'forever' ;-)
> 
>> And what is the status of the dd when it hangs ?
>> Can you take some samples of the /proc/<dd's pid>/status and /proc/<dd's pid>/stack during the hang ?
> Sadly, I cannot access this information once the shell locks up.
> 
> However, the kernel did print many warnings overnight (see below).
> 
>> And also would you please share the dmesg log and config ?
> See below.
> 
>> Since always fails with buffered read with fixed bytes,
>> what is the capacity of your system memory ? 
> 4GB RAM. And the system hangs after reading 3.8GB
> I think this is not a coincidence.
> NB: swap is disabled (this might be relevant)

Look through the log
https://pastebin.ubuntu.com/p/YSm82GxhNW/

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:    6-...0: (13995 ticks this GP) idle=e16/1/0x4000000000000000 softirq=155/155 fqs=655 
rcu:    (detected by 4, t=576151 jiffies, g=-391, q=18)
Task dump for CPU 6:
dd              R  running task        0   677    671 0x00000002
Call trace:
 __switch_to+0x174/0x1e0
 ufshcd_queuecommand+0x84c/0x9a8

The task is in RUNNING state when it was scheduled out.
So it should be a preempt (the path is under preemptible rcu).

And I wonder why it is not scheduled back for so long time that rcu stall was triggered.
And who was occupying the cpu all the time ?

Would you please try to show all running tasks on all cpu ?

echo l > /proc/sysrq-trigger

In addition, since the rcu grace period didn't pass, a lot of things could not be moved
forward.

Thanks
Jianchao
