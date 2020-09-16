Return-Path: <SRS0=dDIv=CZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA3CC433E2
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B9621973
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 18:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hMnf6nX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgIPS4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:56:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58126 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbgIPSzg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Sep 2020 14:55:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GEtOQo005754;
        Wed, 16 Sep 2020 14:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DUWtBQ904zucZN69+hZrcZGKYdDwE5YDnwuTFvrxAmw=;
 b=hMnf6nX3DCFhe52M/KcV7IpF7JulzHOgH41j1cggMAc6IewHEjte9yTSOMciKIVIbBsS
 5pF/QorW1NQ8qPsAYARFjyZVhljQEybmOwcads39E8864+rTV1hZ4Xdx0q7PfZKbsdK4
 Q4Sv1SLaFSu4M4BRq4K7eegnhnWL/GiElIYxRkkE1QABwBz0dXsF9IRF+o7hHE3a3guw
 dngFU8InouCawbeDJpmmz+88hkzjAiHTFSuy5EX3vNrkIRrtUX0/PA9xQs7Ly2+6M3uj
 OJ8AN4vBYFvN4DKS4bW4lx6ow1adRZffU0NRbENSfZ0mPWLBGQ9XQa6nH5CZXXndOFlG LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33gp9mbkbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 14:56:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GEil7j148640;
        Wed, 16 Sep 2020 14:56:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33h891sjhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 14:56:23 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08GEuMam016574;
        Wed, 16 Sep 2020 14:56:22 GMT
Received: from [10.191.205.213] (/10.191.205.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 14:56:22 +0000
Subject: Re: Revert "dm: always call blk_queue_split() in dm_process_bio()"
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Somu Krishnasamy <somasundaram.krishnasamy@oracle.com>,
        dm-devel@redhat.com,
        RAMANAN_GOVINDARAJAN <ramanan.govindarajan@oracle.com>
References: <529c2394-1b58-b9d8-d462-1f3de1b78ac8@oracle.com>
 <20200910142438.GA21919@redhat.com>
 <5261af10-bf5c-f768-dbeb-2e784a5823f9@oracle.com>
 <20200915013308.GA14877@redhat.com>
From:   Vijayendra Suman <vijayendra.suman@oracle.com>
Organization: Oracle Corporation
Message-ID: <1e90b391-416e-b32d-681c-16a029e8bf54@oracle.com>
Date:   Wed, 16 Sep 2020 20:26:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915013308.GA14877@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160112
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Mike,

On 9/15/2020 7:03 AM, Mike Snitzer wrote:
> On Thu, Sep 10 2020 at  3:29pm -0400,
> Vijayendra Suman <vijayendra.suman@oracle.com> wrote:
>
>> Hello Mike,
>>
>> I checked with upstream, performance measurement is similar and
>> shows performance improvement when
>> 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 is reverted.
>>
>> On 9/10/2020 7:54 PM, Mike Snitzer wrote:
>>> [cc'ing dm-devel and linux-block because this is upstream concern too]
>>>
>>> On Wed, Sep 09 2020 at  1:00pm -0400,
>>> Vijayendra Suman <vijayendra.suman@oracle.com> wrote:
>>>
>>>>     Hello Mike,
>>>>
>>>>     While Running pgbench tool with  5.4.17 kernel build
>>>>
>>>>     Following performance degrade is found out
>>>>
>>>>     buffer read/write metric : -17.2%
>>>>     cache read/write metric : -18.7%
>>>>     disk read/write metric : -19%
>>>>
>>>>     buffer
>>>>     number of transactions actually processed: 840972
>>>>     latency average = 24.013 ms
>>>>     tps = 4664.153934 (including connections establishing)
>>>>     tps = 4664.421492 (excluding connections establishing)
>>>>
>>>>     cache
>>>>     number of transactions actually processed: 551345
>>>>     latency average = 36.949 ms
>>>>     tps = 3031.223905 (including connections establishing)
>>>>     tps = 3031.402581 (excluding connections establishing)
>>>>
>>>>     After revert of Commit
>>>>     2892100bc85ae446088cebe0c00ba9b194c0ac9d ( Revert "dm: always call
>>>>     blk_queue_split() in dm_process_bio()")
>>> I assume 2892100bc85ae446088cebe0c00ba9b194c0ac9d is 5.4-stable's
>>> backport of upstream commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 ?
>> Yes
>>
>>>>     Performance is Counter measurement
>>>>
>>>>     buffer ->
>>>>     number of transactions actually processed: 1135735
>>>>     latency average = 17.799 ms
>>>>     tps = 6292.586749 (including connections establishing)
>>>>     tps = 6292.875089 (excluding connections establishing)
>>>>
>>>>     cache ->
>>>>     number of transactions actually processed: 648177
>>>>     latency average = 31.217 ms
>>>>     tps = 3587.755975 (including connections establishing)
>>>>     tps = 3587.966359 (excluding connections establishing)
>>>>
>>>>     Following is your commit
>>>>
>>>>     diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>>>>     index cf71a2277d60..1e6e0c970e19 100644
>>>>     --- a/drivers/md/dm.c
>>>>     +++ b/drivers/md/dm.c
>>>>     @@ -1760,8 +1760,9 @@ static blk_qc_t dm_process_bio(struct mapped_device
>>>>     *md,
>>>>              * won't be imposed.
>>>>              */
>>>>             if (current->bio_list) {
>>>>     -               blk_queue_split(md->queue, &bio);
>>>>     -               if (!is_abnormal_io(bio))
>>>>     +               if (is_abnormal_io(bio))
>>>>     +                       blk_queue_split(md->queue, &bio);
>>>>     +               else
>>>>                             dm_queue_split(md, ti, &bio);
>>>>             }
>>>>
>>>>     Could you have a look if it is safe to revert this commit.
>>> No, it really isn't a good idea given what was documented in the commit
>>> header for commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74 -- the
>>> excessive splitting is not conducive to performance either.
>>>
>>> So I think we need to identify _why_ reverting this commit is causing
>>> such a performance improvement.  Why is calling blk_queue_split() before
>>> dm_queue_split() benefiting your pgbench workload?
>> Let me know if you want to check some patch.
> Hi,
>
> Could you please test this branch?:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.10__;!!GqivPVa7Brio!MspX41fnl1XoqlkHjwMuNFk--2a9yMSV9IQMRazyHTKEPls1nuF37bSIum7ZAOLZGxk6kw$
> (or apply at least the first 4 patches, commit 63f85d97be69^..b6a80963621fa)

With above mentioned patch set, I get following results

buffer ->

number of transactions actually processed: 1001957
latency average = 20.135 ms
tps = 5562.323947 (including connections establishing)
tps = 5562.649168 (excluding connections establishing)

cache ->

number of transactions actually processed: 581273
latency average = 34.745 ms
tps = 3223.520038 (including connections establishing)
tps = 3223.717013 (excluding connections establishing)

With above patch there is performance improvement.

> So far I've done various DM regression testing.  But I haven't tested
> with pgbench or with the misaaligned IO scenario documented in the
> header for commit 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74.  But I'll
> test that scenario tomorrow.
>
> Any chance you could provide some hints on how you're running pgbench
> just so I can try to test/reproduce/verify locally?
A PostgreSQL setup script will run as part of the setup within RUN to 
install the PostgreSQL DB, configure the /etc/postgresql.conf file and 
initialize the DB.
The RUN script will start the PostgreSQL service and bind it to running 
on half the cpu's, a DB will be created of a default size (I think 16M) 
and will be scaled up to the required size based on whether it is a 
buffer, cache or disk run.

After this, PostgreSQL pgbench will be run in readonly and readwrite 
modes (and be binded to the other half of the cpu's on the system).

Performance issue was seen on readwrite mode.

>
> Thanks,
> Mike
>
