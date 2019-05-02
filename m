Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ABBC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 21:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE5A2081C
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 21:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEBV3i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 17:29:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725995AbfEBV3i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 May 2019 17:29:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42LRDka050596
        for <linux-block@vger.kernel.org>; Thu, 2 May 2019 17:29:36 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s889d8eu2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 02 May 2019 17:29:36 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
        Thu, 2 May 2019 22:29:35 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 22:29:33 +0100
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42LTW5f30671076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 21:29:32 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75934124054;
        Thu,  2 May 2019 21:29:32 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B3BD124052;
        Thu,  2 May 2019 21:29:32 +0000 (GMT)
Received: from oc6034535106.ibm.com (unknown [9.10.86.114])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 21:29:32 +0000 (GMT)
Subject: Re: [PATCH 0/5] block/target queue/LUN reset support
To:     Hannes Reinecke <hare@suse.de>,
        Mike Christie <mchristi@redhat.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org
References: <1464162903-14735-1-git-send-email-mchristi@redhat.com>
 <574BDFB7.5000407@suse.de> <574DEC57.7090701@redhat.com>
 <574E7B0D.4080401@suse.de>
From:   Brian King <brking@linux.vnet.ibm.com>
Date:   Thu, 2 May 2019 16:29:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <574E7B0D.4080401@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050221-0060-0000-0000-00000337B0B1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011037; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197673; UDB=6.00628192; IPR=6.00978529;
 MB=3.00026704; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-02 21:29:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050221-0061-0000-0000-0000492E26C5
Message-Id: <c1040d5e-64fb-2b92-5090-497238e195d1@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020134
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/1/16 1:05 AM, Hannes Reinecke wrote:
> On 05/31/2016 09:56 PM, Mike Christie wrote:
>> On 05/30/2016 01:37 AM, Hannes Reinecke wrote:
>>> On 05/25/2016 09:54 AM, mchristi@redhat.com wrote:
>>>> Currently, for SCSI LUN_RESETs the target layer can only wait 
>>>> on bio/requests it has sent. This normally results in the 
>>>> LUN_RESET timing out on the initiator side and that SCSI error 
>>>> handler escalating to something more disruptive.
>>>> 
>>>> To fix this, the following patches add a block layer helper and
>>>> callout to reset a request queue which the target layer can use
>>>> to force drivers to complete/fail executing requests.
>>>> 
>>>> Patches were made over Jens's block tree's for-next branch.
>>>> 
>>> In general I like the approach, it just looks as if the main aim 
>>> (ie running a LUN RESET concurrent with normal I/O on other 
>>> devices) is not quite reached.
>>> 
>>> The general concept of eh_async_device_reset() is quite nice, and
>>> renaming existing functions for doing so is okay, too.
>>> 
>>> It's just the integration with SCSI EH which is somewhat 
>>> deficient (as outlined in the comment on patch 3). For the async 
>>> device reset to work we'd need to call it _before_ SCSI EH is 
>>> started, ie after the asynchronous command abort failed.
>> 
>> Yes that is my plan.
>> 
>> However, these first patches are only to allow LIO to be able to do
>> resets. I need the same infrastructure for both though.
>> 
>>> 
>>> The easiest way would be to add per-device reset workqueue item,
>>>  which wold be called whenever command abort failed.
>> 
>> If you want to do this without stopping the entire host, you need 
>> the patches like in this set where we stop and flush a queue.
>> 
> Sure.
> 
>>> As it's being per device we'd be getting an implicit 
>>> serialisation, and we could skip the lun reset from EH.
>> 
>> To build on my patches for a new async based scsi eh what we want 
>> to do is:
>> 
>> 0. Add eh_async_target_reset callout which works like async device 
>> reset one. For iscsi this maps to iscsi_eh_session_reset. FC 
>> drivers have something similar in the code paths that call 
>> rc_remote_port_delete and the terminate_rport_io paths. We just 
>> need wrappers.
>> 
> Actually, I was wondering whether we could layer the new async EH 
> infrastructure besides the original EH.
> 
> And the current 'target_reset' is completely wrong. SAM-2 did away 
> with the TARGET RESET TMF, so it's anyones guess if a target reset
> is actually _implemented_. What we really need, though, is a new 
> 'eh_async_transport_reset' function, which would reset the 
> _transport_. A transport failure is currently main (and I'm even 
> tempted to say the only) reason why EH is invoked.
> 
>> 1. scsi_times_out would kick off abort if needed and return 
>> BLK_EH_RESET_TIMEOUT. 2. If abort fails, cancel queued aborts and 
>> call new async device reset callout in these patches. 3. If device 
>> reset fails call new async target reset callout. 4. if target
>> reset fails, let fail the block timeout timer and do the old style
>> scsi eh host reset.
>> 
> I would suggest to replace 3. and 4. with:
> 
> 3. If device reset fails call the new async transport reset callout 
> 4. If transport reset fails fallback to the original SCSI EH (which 
> would have abort and device reset callouts unset, so it'll start
> with a target reset)
> 
> That way we keep the existing behaviour (so we don't need to touch 
> the zillions of SCSI parallel drivers) _and_ will be able to model a
>  reasonably modern error handling.
> 
>> It is really simple for newer drivers/classes like FC and iSCSI 
>> because they handle the device and target/port level reset clean
>> up already. The difficult (not really difficult but messy) part is 
>> trying to support old and new style EHs in a functions like 
>> scsi_times_out and scsi_abort_command.
>> 
> And indeed, that's the challenge. But your patchset is a step into 
> the right direction. I see if I can make progress with it, although 
> I'm currently busy doing the next release so it might take some 
> time.


Recently I've been looking at some issues we are seeing in the field with customers
that have very large storage configurations with lots and lots of SAS drives. We are seeing scenarios
where drive head failures and other issues are resulting in command aborts that then ultimately fail
and we then quiesce the HBA in order to do the LUN reset. Since this configuration has
hundreds of SAS disks under a single HBA, that results in a very noticeable I/O service time
problem for all the other disks under that HBA due to one misbehaving drive. We've so far
focused most our efforts on getting other components in the stack to behave differently
in order to mitigate the issue. However, that doesn't mean we can't do better
in the kernel. 

The direction this patch set was headed was to implement async LUN reset, something we've
discussed for years, but never fully implemented.  Is this something anyone else is still
seeing as an issue for them in other environments? Given that the last attempt at implementing
this, from what I can tell, happened now three years ago and then stalled, I'm afraid
I know the answer, but is anyone actively working on anything like this?

Thanks,

Brian


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

