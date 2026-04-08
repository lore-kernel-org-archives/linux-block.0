Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5909379EF6
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775676957; cv=none; b=mGU2adO5tnq6F6rMKVkv1M82lrX4o0t8cPwX/XxRvXDy11dAmbNEHOHtIhwmMhe+JtbAbD75mnKSpZnlBPvhBMskqdFWV7XQx2KZ5S1b3JaN2oHYIKfQfstRmpDp5j3W/rwWmKwj/9O1doSCobOZPubw4KdcAOvDJmbk3Jk7WK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775676957; c=relaxed/simple;
	bh=FtehZzc3TFurHrC37Kc6r2VFZZOATrcOKFy5M3V08TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfgitnhdFmsenAb3TSZAS4BR4F5r9/f/DdBu5qc1+iUHt8G6i0Hudjdehy2dMd9L4nqYk/6Zk81iEBX7I4TDjfnlLVm8gmqo8E3mZ5FUI+npGtgAiRfaN8dh0d16FrqS4pc//WNGXCZUIb0PDyFDyE6ro0MNG9xZsOwoC60Yl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Bh99876D; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Bh99876D"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638JMwJ43909736
	for <linux-block@vger.kernel.org>; Wed, 8 Apr 2026 15:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=E4LG
	Lk/CDNL83hlgUo8iXk9zFAF5PxXFc3V0NN89y0o=; b=Bh99876DlThe4BSrmYhz
	BT49B/aYdNpnd5iXtmahdBmWQKp/nLM7EjQidIcVzMQu0zTcB9WhKQoUhcQ56heK
	5zV2ZTddiaC6RxhQMa/3ecHH0Fzml6zO4IzVbRJpnOjJvzciBUaBCwXgbtXVeneK
	FP8Xt+w6gyqpBzKGjC7/1oEVDvOHhqumfe7LK/Evxpw9i8BV/Ak2Ti10fNw+JAlH
	K10VNlfSBV4KFxb6JDcQUQ+uB/at25i24L1wPVi51/y+nQY78gxCvOr5ponpRO2s
	LXoItPMPFOhAkpFIu+qalKnqsA0rBuc8xR5faWwr1DuNe9DlvITzCPq2Bak+N1Tj
	Zg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3kybkq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 15:35:55 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b52a2d70cso4572961cf.3
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 12:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775676954; x=1776281754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4LGLk/CDNL83hlgUo8iXk9zFAF5PxXFc3V0NN89y0o=;
        b=R5Ozhp28xgj+A8q4agHm2MjE6Ya13wf/lwywPNgk1owIu54PcPD88Ly/IYtEvLr7z+
         1E0noOTXQS5U+KRm5AMSG5A0KkVXciSVcfjVqlgZ87yHjowP21h8oqD3WSerx8vh0sTB
         VLvsNcTpSdIV9M3pTEoDwXwZ5FPeHbgMVKaUpWN8kSKchmsS7UYR44M5tg0gCfi+LLKZ
         e5LYO8ETeAzSCIdeNEls9tWB3x6mfdzxeHafXxEFubZmM5/SYYSOuctSwaL85OGk3ryR
         JOhsfMy4T2rKZzYSICO58nuQIHjX7wUWaIWG36QLM7XYx2Gabs8iCJvpXyjZtV0K5Ai7
         +aBg==
X-Forwarded-Encrypted: i=1; AJvYcCXrcqbtZKl9TlmmUt1cq5/js2E1+WLjS2qoWFfxXbb1XGwgKpU7lC6ZkATdhFXcmtVs3tTzHGS8bJdpUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33gJ8VhNMYZPEwESMaSYvHSOTxTeOBEr/K6/GoQX54PlqdXWh
	YPH5pHpNWYxmK8AeFf51prLD+Hd+2+SwcuoYnlY+WJrqmirlngyFrGg5xisWVMdozIdCjIHK1XR
	Wq6dyg6mqVlZSkNZMkGZAI+2u37w+h+FuMFtZyVVMK++jHaPnMi02RUOnTAka
X-Gm-Gg: AeBDievzv+n1SEv8psFMZ0bUmFYvfHDJ3NMqwN76e3+wlLj/1y9z6bnz/XsmXOBDAuU
	/KxOKPS5DSbLfJsyBTrLLVw7BPch02EBGL7S4oP2RezL4VJgmvFhcxuCuofZR7y7yFOJatwBly3
	joB7Uqta0xkpnvaq4bTJrcyf1a7GkU7s4ROoJ/4kfAA24cgQjgeMR7rnZiKiDsvTaBdZ5E2d307
	SWgBRp7LW4F55IRrsX7uYR78gzLpx1kmtRNq1iC7clZ5qiPzoTZOtqXU2PYbPCsHQTf1jpXJ87s
	dAa9CkMEP467uRdprUgAS4/LnIzloC7RFE6c34ykXLxHF8W4SX1/ZxhX41+0InZjdHdn/nymGBZ
	DTCxxiSfprZJP0W5czMk1bT4y4U8beU+ZHzeXZz8q
X-Received: by 2002:ac8:5908:0:b0:50d:a987:89b2 with SMTP id d75a77b69052e-50da98798fdmr100185521cf.31.1775676954047;
        Wed, 08 Apr 2026 12:35:54 -0700 (PDT)
X-Received: by 2002:ac8:5908:0:b0:50d:a987:89b2 with SMTP id d75a77b69052e-50da98798fdmr100185051cf.31.1775676953617;
        Wed, 08 Apr 2026 12:35:53 -0700 (PDT)
Received: from [192.168.129.206] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d82afc7d5sm126128111cf.30.2026.04.08.12.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 12:35:52 -0700 (PDT)
Message-ID: <52016a51-58c7-41eb-8824-3c133aab90b2@columbia.edu>
Date: Wed, 8 Apr 2026 15:35:52 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] block: add BIO_COMPLETE_IN_TASK for
 task-context completion
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
 <20260325-blk-dontcache-v4-1-c4b56db43f64@columbia.edu>
 <acYdOOpo51xrzNBg@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <acYdOOpo51xrzNBg@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MsFiLWae c=1 sm=1 tr=0 ts=69d6ae1b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=h9G_tkD_DQui4U1ChFoA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: GQdVgflb5zlS1GjRNqeyoHCx-YV3aNxw
X-Proofpoint-GUID: GQdVgflb5zlS1GjRNqeyoHCx-YV3aNxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MyBTYWx0ZWRfX4KqFdl6+PtaK
 MNPWV1eD1aWaf3Cfq6XociIoMm6R6qOUQGgt2pnOyKOLv7vqXHh8eUEkQHMPSn8ifq8gfvATplg
 cIJNvXavdlGgwa7qEDgzbn2XGlmQDGcGqTLYaCtGQaXguJfJoJ73vh2xUy3izL7vN/pjYbzo3Qk
 CsAfndaOsyettykq7HPr5zQu+B2wJoi5NIU5FhFFije+bTKUXHy7m3Q2HeLqj0Spoa5M/Q3r+a5
 9rT2RoC07tCjbBjpt6921Rq4bJIgNzk1VxLU/JqIcWBULQEJ5L/Zwv0xRhj3W7pYxL3D81EskjU
 gzj9vAhz8OvRmlUjt1VQ64WXResspGdfFXyVloOjpxv3PDkgEEvosGGin2Cww2wOujPVUsReXyE
 d/Ia9rxPWeVJruEB/ObpwdMMWX51BhB6iwWbbce/Ioe2UlzDkeEZ6v02g9es1EC7Z8BZ3xwMjgt
 01idoVvrIZBV7G7JPNA==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=10 clxscore=1015
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=10
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080183



On 3/27/26 2:01 AM, Christoph Hellwig wrote:
> On Wed, Mar 25, 2026 at 02:43:00PM -0400, Tal Zussman wrote:
>> +static void bio_complete_work_fn(struct work_struct *w)
>> +{
>> +	struct bio_complete_batch *batch;
>> +	struct bio_list list;
>> +
>> +again:
>> +	local_lock_irq(&bio_complete_batch.lock);
>> +	batch = this_cpu_ptr(&bio_complete_batch);
>> +	list = batch->list;
>> +	bio_list_init(&batch->list);
>> +	local_unlock_irq(&bio_complete_batch.lock);
>> +
>> +	while (!bio_list_empty(&list)) {
>> +		struct bio *bio = bio_list_pop(&list);
>> +		bio->bi_end_io(bio);
>> +	}
> 
> bio_list_pop already does a NULL check, so this could be:
> 
> 	while ((bio = bio_list_pop(&batch->list)))
> 		bio->bi_end_io(bio);
> 
> In fact that same pattern is repeated later, so maybe just add a helper
> for it?  But I think Dave's idea of just using a llist (and adding a
> new llist member to the bio for this) seems sensible.  Just don't forget
> the llist_reverse_order call to avoid reordering.

Will switch to llist.

>> +
>> +	local_lock_irq(&bio_complete_batch.lock);
>> +	batch = this_cpu_ptr(&bio_complete_batch);
>> +	if (!bio_list_empty(&batch->list)) {
>> +		local_unlock_irq(&bio_complete_batch.lock);
>> +
>> +		if (!need_resched())
>> +			goto again;
>> +
>> +		schedule_work_on(smp_processor_id(), &batch->work);
>> +		return;
>> +	}
>> +	local_unlock_irq(&bio_complete_batch.lock);
> 
> I don't really understand this requeue logic.  Can you explain it?

If new bios were queued while we were processing this batch, we loop back
and process them, if we don't need to reschedule. If we do need to
reschedule, we re-queue the work item and return.

>> +	schedule_work_on(smp_processor_id(), &batch->work);
> 
> We'll probably want a dedicated workqueue here to avoid deadlocks
> vs other system wq uses.
> 
>> +static int bio_complete_batch_cpu_dead(unsigned int cpu)
>> +{
>> +	struct bio_complete_batch *batch = per_cpu_ptr(&bio_complete_batch, cpu);
> 
> Overly long line.
> 

Will fix.

Thanks,
Tal

