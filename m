Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51A328B47;
	Tue,  9 Dec 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765299674; cv=none; b=cMAclpxgcmp7vgXCVhHuKoSiwK8yV1Reg9uqB0CayNABjaUoEqFKAIH+YTykVKFO/75k/HxiYf2FJm8jDTnqIjLWnAGXZx+meRGCJJXUXqu5hdBroDuFctNdnQFCR3pAsOahl5ELl6GSNK2RDs8veNIhRsIS5qEQZii6axSEf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765299674; c=relaxed/simple;
	bh=bwBv4dIPLgAjiy5eYrWiOJALP/QI+jgbxJNCJQK5hVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z00fqQd3zBs1ixNjY+kbXQTCU6ID1itEhmVNTF7eKwilTI/0T46hh8fF4KaqK6Zt+BHYKr4W42s+/iprM6UB3Z6C6dyCzpVfnayC3ZqpASB28aDKL+5f5V4oZqfk8LRy0lMImjPQNodmiM47Q69gpwUTx2zL4Ih89sWYL572kgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hMxte85s; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hMxte85s"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dQlVT6sRtzlkSBM;
	Tue,  9 Dec 2025 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1765299662; x=1767891663; bh=CCzFtkG3lOL8hHwPACdkZ1Ex
	CfN+JZeKct/e0R4FgRo=; b=hMxte85suXmmIIbBBERNcsjA0H/pK8sZWaZSPO0X
	sMFhy7Ng+bSYhWaJvxy+WdIeZ07CCOBE1LhjNxhHQd6Py9gVZkJjkDB30L913GfI
	6zJfYEbwlco8qOC3ogpPH60xKKkcw31XEvDmTcePxh34JsyN3H00YkRMK+tq0xU3
	w8jRKVfvlWo5IVi+4xh11Gp7Ji1kpyxApf2h8xdRuBWBJVqz6pH8RsooO+7WfGtA
	5AxQXt8n/8O6cA4ENbaCu4IzEeKjZGdv6RzA/q2pOn/mZNrORVNDkZ+nxLZdYBSk
	hOSd80T40PgCSfxluFSzXOiqmE4QfsSpAR3k8TuJjZi6bw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eMD8o5F3SxOF; Tue,  9 Dec 2025 17:01:02 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dQlVH4S9JzlgyGt;
	Tue,  9 Dec 2025 17:00:55 +0000 (UTC)
Message-ID: <1e4c4cb6-e787-4078-b7b0-787bd45ebd78@acm.org>
Date: Tue, 9 Dec 2025 09:00:53 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
To: Hannes Reinecke <hare@suse.de>,
 Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
 <20251205211738.1872244-2-mkhalfella@purestorage.com>
 <eb03af5f-6371-4e3b-acfc-9c3d75403d18@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <eb03af5f-6371-4e3b-acfc-9c3d75403d18@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 12/8/25 11:30 PM, Hannes Reinecke wrote:
>> @@ -4294,7 +4294,7 @@ static void blk_mq_del_queue_tag_set(struct=20
>> request_queue *q)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct blk_mq_tag_set *set =3D q->tag_s=
et;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&set->tag_list_lock);
>> -=C2=A0=C2=A0=C2=A0 list_del(&q->tag_set_list);
>> +=C2=A0=C2=A0=C2=A0 list_del_rcu(&q->tag_set_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list_is_singular(&set->tag_list)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* just transit=
ioned to unshared */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set->flags &=3D=
 ~BLK_MQ_F_TAG_QUEUE_SHARED;
>> @@ -4302,7 +4302,6 @@ static void blk_mq_del_queue_tag_set(struct=20
>> request_queue *q)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_update_t=
ag_set_shared(set, false);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&set->tag_list_lock);
>> -=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&q->tag_set_list);
>> =C2=A0 }
> I'm ever so sceptical whether we can remove the INIT_LIST_HEAD() here.
> If we can it was pointless to begin with, but I somehow doubt that.
> Do you have a rationale for that (except from the fact that you
> are moving to RCU, and hence the 'q' pointer might not be valid then).

My understanding is that calling INIT_LIST_HEAD() after list_del_rcu()
without letting a grace period expire first is not allowed because it
introduces a race condition. From the block layer git history:

commit a347c7ad8edf4c5685154f3fdc3c12fc1db800ba
Author: Roman Pen <roman.penyaev@profitbricks.com>
Date:   Sun Jun 10 22:38:24 2018 +0200

     blk-mq: reinit q->tag_set_list entry only after grace period

     It is not allowed to reinit q->tag_set_list list entry while RCU gra=
ce
     period has not completed yet, otherwise the following soft lockup in
     blk_mq_sched_restart() happens: [ ... ]

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d2de0a719ab8..2be78cc30ec5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2349,7 +2349,6 @@ static void blk_mq_del_queue_tag_set(struct=20
request_queue *q)

         mutex_lock(&set->tag_list_lock);
         list_del_rcu(&q->tag_set_list);
-       INIT_LIST_HEAD(&q->tag_set_list);
         if (list_is_singular(&set->tag_list)) {
                 /* just transitioned to unshared */
                 set->flags &=3D ~BLK_MQ_F_TAG_SHARED;
@@ -2357,8 +2356,8 @@ static void blk_mq_del_queue_tag_set(struct=20
request_queue *q)
                 blk_mq_update_tag_set_depth(set, false);
         }
         mutex_unlock(&set->tag_list_lock);
-
         synchronize_rcu();
+       INIT_LIST_HEAD(&q->tag_set_list);
  }

Thanks,

Bart.
