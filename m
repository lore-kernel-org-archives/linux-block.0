Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E7FC433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 02:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB6364D79
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 02:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhBJCxo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 21:53:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233046AbhBJCxj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Feb 2021 21:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612925532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m7QlwtWzS30BuWDFO152uPTfPDucm0b2WCax1pbe3PM=;
        b=UxbhAmHK6aHTp1FKLXSCHu4OmzGchvRp+AJF0iKpydI3XOozkgnvHLdKpNhWKEy9pctRkv
        YAF282i37SwUixuTAuMf9WqCoL3TBfw7viELGMuUilZzOLhzV3nnP2WorDMPcV3mUpC2LX
        TMRrRSl9RirxWJseYnzFA3295qQiwLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-ythgTaurMiyeIOxVDHKsHQ-1; Tue, 09 Feb 2021 21:52:10 -0500
X-MC-Unique: ythgTaurMiyeIOxVDHKsHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30F1E107ACE6;
        Wed, 10 Feb 2021 02:52:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A218060C4D;
        Wed, 10 Feb 2021 02:51:59 +0000 (UTC)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>
Cc:     axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Chaitanya.Kulkarni@wdc.com, Ming Lei <ming.lei@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
 <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
 <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <1a520912-ac7c-1a3c-c432-b382a5da6177@redhat.com>
Date:   Wed, 10 Feb 2021 10:51:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/10/21 2:01 AM, Sagi Grimberg wrote:
>
>>>>> Thanks for reporting Ming, I've tried to reproduce this on my VM
>>>>> but did not succeed. Given that you have it 100% reproducible,
>>>>> can you try to revert commit:
>>>>>
>>>>> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
>>>>>
>>>>
>>>> Revert this commit fixed the issue and I've attached the config. :)
>>>
>>> Hey Ming,
>>>
>>> Instead of revert, does this patch makes the issue go away?
>> Hi Sagi
>>
>> Below patch fixed the issue, let me know if you need more testing. :)
>
> Thanks Yi,
>
So it's nvme_admin_abort_cmd here

[   74.017450] run blktests nvme/012 at 2021-02-09 21:41:55
[   74.111311] loop: module loaded
[   74.125717] loop0: detected capacity change from 2097152 to 0
[   74.141026] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   74.149395] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   74.158298] nvmet: creating controller 1 for subsystem 
blktests-subsystem-1 for NQN 
nqn.2014-08.org.nvmexpress:uuid:41131d88-02ca-4ccc-87b3-6ca3f28b13a4.
[   74.158742] nvme nvme0: creating 48 I/O queues.
[   74.163391] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[   74.184623] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 
127.0.0.1:4420
[   75.235059] nvme_tcp: rq 38 opcode 8
[   75.238653] blk_update_request: I/O error, dev nvme0c0n1, sector 
1048624 op 0x9:(WRITE_ZEROES) flags 0x2800800 phys_seg 0 prio class 0
[   75.380179] XFS (nvme0n1): Mounting V5 Filesystem
[   75.387457] XFS (nvme0n1): Ending clean mount
[   75.388555] xfs filesystem being mounted at /mnt/blktests supports 
timestamps until 2038 (0x7fffffff)
[   91.035659] XFS (nvme0n1): Unmounting Filesystem
[   91.043334] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"


> I'll submit a proper patch, but can you run this change
> to see what command has a bio but without any data?
> -- 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 619b0d8f6e38..311f1b78a9d4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2271,8 +2271,13 @@ static blk_status_t 
> nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
>         req->data_len = blk_rq_nr_phys_segments(rq) ?
>                                 blk_rq_payload_bytes(rq) : 0;
>         req->curr_bio = rq->bio;
> -       if (req->curr_bio)
> +       if (req->curr_bio) {
> +               if (!req->data_len) {
> +                       pr_err("rq %d opcode %d\n", rq->tag, 
> pdu->cmd.common.opcode);
> +                       return BLK_STS_IOERR;
> +               }
>                 nvme_tcp_init_iter(req, rq_data_dir(rq));
> +       }
>
>         if (rq_data_dir(rq) == WRITE &&
>             req->data_len <= nvme_tcp_inline_data_size(queue))
> -- 
>

