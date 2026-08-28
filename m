Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333BB374A15
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932573; cv=none; b=s0UuyrIRscaZWKSVPHt0gzXI0Y5tXCKjsjgAETdT6xJw0RA/BAof9+FB8R/Clx8UYv+twLXF90BvYFQ1r0Y4b1Sb/YoLzg7f/+uwUPELdOOjLQ3ucEcysX8krCx+g80lAKyhOhu4wbAdexdfz455aoIVQsQsBPknSe+/ytkCu7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932573; c=relaxed/simple;
	bh=YPFAfwgLXyRYWu0qKDT7O8z9rx4Le0VUAMpakSNW0Is=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qsicOoHkDMVH7C4B0+d2hemGfmoDEmTRk6GCogvYOItKuhWO/M61WD0Kyf5fjXnduqstU28/jVOuNBSZrsfrbRRGNr8ZKtykrJDePjWyjhOZ8uzhkTMcd72w2UHVGJMFdDoqgBY4UsIiG3dhuvYfYqd/H1g+9rzKxWJI+0S+f4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DvsjZ2Ls; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fuBiHdcH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DvsjZ2Ls";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fuBiHdcH"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDkwar2631943
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 15:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QWK2pao1WAM8yI8Fl2//fFtzpUUZCvVVyo5r8hizPUA=; b=DvsjZ2LsVsvmIPjD
	cj7LSSEwmXlDTK+zsDzSAGaxZlfNi+MtDuMlbE9tq/aGlM4kd991+VMkWZITv1AP
	ZDtm/5x6tea1dQQp/stuFNciPiC2wsHtjI0W83fbewoGJ5F2d2TP0txv23SXXDUM
	x5Np1nwAagHAeY94LmjuSfTcCpkOiH9FZp8qji89R/Czmwpz+tI78oBJUFIU2OP1
	EBf64brrOr/k+4w5NENc4R1Nk2xv/skup7H0UdrEVW2pUJ7m0KsZkffsK9fvU/52
	/NdgLhOuTD28ELOrSvt7RXkv9GjhTKW7Oih9zefr/eASuUxpYJ/q5PdbQfXy24KO
	/go55w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42ragj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 15:56:09 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b8088202so1207347a12.3
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787932569; x=1788537369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QWK2pao1WAM8yI8Fl2//fFtzpUUZCvVVyo5r8hizPUA=;
        b=fuBiHdcHuZ/XGaCDvtUVfiyfrowD6FYbBDOz3FAV1kEjxIyZq10BJn4BpaNT7NOocM
         bDLXqdolxBhi7VQt5RwpaYx4fCTlCSQtFuJ8cYIS/y+oVN7cyEphWdnIfG4aCKtcF8Ry
         42gPeprh1spF1tnYeWmImNJd97e4jfR5KfUbsdCbH4jH/2+zv/cV/k4+zpY1Dn9Ctvhi
         BFYIVmgjIn7CkLK9DSfglyYCSAJao2vuAQdsAN9XwnFL/A5pnJ+FNu4qu91LWYgXjUlZ
         Rd3O0/a5l1QS+OBqUCGEK3I+85f8CdjYhOs5yCbP+5Ia22RDkxUBNYjNY+jPunjwxmZr
         a1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932569; x=1788537369;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QWK2pao1WAM8yI8Fl2//fFtzpUUZCvVVyo5r8hizPUA=;
        b=f4haAs/a90kT9M3r3z5OXLbaUHWsITS9hxiD92WlTmzOoiVKVPSMI7T0hjOTp3TzB9
         eM+fEsqtfomccBg0Y7cXPc6obBv0B7uW2Wp52pUKtZZ1owAyZ3WBInLWpRdUgRNl4BwI
         3B2cVMVmNBhaG+DhfI8rGdJBk1coamaK76k3+XVNKLi4ShLM42bSkbYhIu7DnqVBqU2i
         8+Qgvbr3ROApcwoUPipliLVIsq137q6Mnu2jEARcICWBDhIWr//QeJCcosuL63UVP4Oy
         NGwPHfdJN+HjD4GoL5izypfFGZmxWPg8y8xQxS7m5HzpIWnnJmMrQnvWC8VhospVCJRn
         NZMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqY+Ctp1MIOm24U2p5oCOcQnov8z4U4a6gmC0GmzNMGemjk7F+Xx6CTN86IsfHfpNKCPcEYTlDxFDZPZg==@vger.kernel.org
X-Gm-Message-State: AFuF++miPgAE3VpYW/OzsXNkdzf5O8ehjP64+4PPhplUI4sPfj8d4jRj
	p9hx7ktl2BWPsEhzrMedUuc7Ee51qNeBoREJh8K3+D1P+VHOTim0AlTo5+l+F6JL1qHjWLKjcY4
	a9doIqtVMLGKF6Y94Aid9xhUmTZBcgcekjzIQj3bQv6P2ukIUZ31odukMSL1CmBDSrA==
X-Gm-Gg: AR+sD11ZxU8S7gQ3QzcPzHBNTQ03sieF/NHIVd90NdDY6DyiQ5sq2rDR7ZxT9GEa8wg
	80tP3ZkH2XJpWAX64UEcDMJpYorpHzirA+zaJbyyPi1k0p2Dq4PRNHoUX6dCK+Z7+hvughvJFbA
	gqD9Uu9YgFs5mbWLbMlYOYV4XTPK8zcgH93mCOzDN1aabm8c6Ftd8LM6RD2c4wRzuY2q1R5QWi2
	oWkLqVhyRDRr0hl9sK7L7nW4IR4VCqIIPzvs7YE5IrBnYznpMoSj4IsBCTlDCON9wfLjaWvCrF7
	UkgXw5yvHYcSj7Ds/uCxWGkezMtfDzpZxsk6rL6W7J6MYUTgDwsowOuw6Bpy0tdIOibF6A9K/hO
	V2n4ClKaGZ0C1sF9Kt+oSjuCsZCXTIVbpNjiOWMYPsZ7yoBHb4dI3hN67fKQ=
X-Received: by 2002:a05:6a20:a11c:b0:3d3:adbf:777f with SMTP id adf61e73a8af0-3d3adbf8124mr1206750637.20.1787932568993;
        Fri, 28 Aug 2026 08:56:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11c:b0:3d3:adbf:777f with SMTP id adf61e73a8af0-3d3adbf8124mr1206667637.20.1787932568530;
        Fri, 28 Aug 2026 08:56:08 -0700 (PDT)
Received: from [10.110.102.109] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm6433151eec.27.2026.08.28.08.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 08:56:08 -0700 (PDT)
Message-ID: <431215e8-1c80-4aa4-8407-5b3779c344f8@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 23:56:00 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] FBE virtualization: inline encryption for
 virtio-blk guests
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        neeraj.soni@oss.qualcomm.com, gaurav.kashyap@oss.qualcomm.com,
        mani@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        bvanassche@acm.org, alim.akhtar@samsung.com, avri.altman@sandisk.com,
        stefanha@redhat.com, pbonzini@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
 <20260827184219.GB2137493@google.com>
 <d81e347e-8ca7-40a1-a428-5bce6f0d4b02@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d81e347e-8ca7-40a1-a428-5bce6f0d4b02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GdcM7uk2RCrwzuKyTJ4kMbFCh4w67YTu
X-Proofpoint-ORIG-GUID: GdcM7uk2RCrwzuKyTJ4kMbFCh4w67YTu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzOCBTYWx0ZWRfX9AvuJcBPgKtD
 iYiAhh8EshZlC6R5bfyl2AqiYJdkyuPya5cRDia5TeHskmDO9Hpbgg3Wmgrq7Rd2xgkhLe3rI7S
 MlYHrU/Be2HeL8nzUgEzTulNA3tznwWU0jGBuNEjxB5FunV4oMxcyRlIgmqs0GRuVqtwO36Cl82
 o2a4MUb9nVhDqmgNfR/RqpuGxt/b687TTEOlTSRtFCTGvsQoo2reo9iilIX6HzqI+UldNP4KjHe
 8oaMqStTEvwk0OQnHscII7S29R5H3HsfaUad81fXM2m0T0buyNu4hAdhYlmcqUKPAvDbJLLNILU
 tE/UaOqoCmb2X3VXCtQxYT/GTibtNyA9wX9AytJELKrIkF3jDGhbZV7q36UarE/yu0yLEObqU9a
 CfDwP11EzWyg7JN/GDYHHc7eM6CBMHFSR5jVVcHO39P4Jh7LoRywaSOdbnKf1WnvRgQUINfa2px
 H8SCU5J7DyC7Jve3p/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzOCBTYWx0ZWRfX4zju/Y6585Um
 FdngLmabcDHYMgq/7e8uHR+y5LlotsNH71M6yk9lU/vlmNQmCkfQl6eKXGcIUtmsXfZl+aE73n/
 AQhl2vh8MOozxkygItR4C59DeW4sBp0=
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=6a91af99 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_h6NAR8LnRz2utxSRfIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280138



On 8/28/2026 11:37 PM, Linlin Zhang wrote:
> 
> 
> On 8/28/2026 2:42 AM, Eric Biggers wrote:
>> On Thu, Aug 27, 2026 at 09:07:09AM -0700, Linlin Zhang wrote:
>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>
>>> Current virtio-blk does not provide a mechanism for a guest to
>>> program hardware keys or submit encrypted I/O using pre-programmed
>>> keyslots.  It drops the crypto context when issuing a bio request
>>> to the virtio-blk queue, preventing inline-encryption-based FBE
>>> on virtio block devices.
>>>
>>> This series enables File-Based Encryption in guest VMs on Qualcomm
>>> GVM platforms where the ICE inline encryption hardware is shared
>>> between the host and guests.  In this environment the guest kernel
>>> has no access to the ICE hardware directly; it supplies a virtual
>>> keyslot index and data unit number with each encrypted I/O request
>>> via VIRTIO_BLK_F_INLINE_ENCRYPTION, and the host must translate the
>>> virtual slot to a physical ICE keyslot and submit the bio — without
>>> transferring raw key material across the VM boundary.
>>
>> This seems to be designed incorrectly by not making virtio-blk itself
>> support key programming and eviction.  That complicates things
>> significantly by then having to handle the key programming and eviction
>> out-of-band using Qualcomm-specific SCM calls.  It also means that
>> adding other implementations of this would be very difficult.
>>
>> There are some claims that not transmitting keys across the VM boundary
>> is desirable.  But that doesn't seem meaningful, given that all the I/O
>> is transmitted across that boundary in plaintext anyway, and also it
>> seems that hardware-wrapped keys will be supported too.
>>
>> Please make virtio-blk support the key programming, eviction, and
>> HW-wrapped key management operations that are needed for this to work.
>>
>> - Eric
> 
> Thanks for your comments!
> 
> Not making virtio-blk itself support key programming and eviction is
> something done deliberately. Based on that HW-wrapped key management
> operations are also handled in the out-of-band path.
> 
> There are bellow 2 approaches I investigated to let virtio-blk programming
> the key.
> 
>   1. virtio_blk implements blk_crypto_ll_ops interfaces, including program
>      key and evict key interfaces.(Same to 'the virtio-blk interface standardized
>      blk_crypto_ll_ops requests' mentioned by Stefan in the virtio SPEC thread)
> 
>      The guest's block crypto profile manages the keyslot in virtual slot
>      format in this scenario.
> 
>       - block crypto key and virt_slot index it passed to the hypervisor's
>        (EL2) device emulation (QEMU, using QEMU in the following) which
>        runs in userspace of the host. Besides of transferring the virtual
>        slot to the physical slot, a programming block crypto key UAPI need
>        be added. Follow current blk-crypto design, it may be like
>        BLKCRYPTOGENERATEKEY. I thought this results in a security risk that
>        allows userspace process a key into a key slot.
> 
>      - For key eviction, it's similar to above key programming handling, also
>        need a key eviction in blk IOCTLs, but leads to the security risk
>        that allow userspace client to evict a key in a key slot.
> 
>     virt_slot, DUN and DUSize is appended to virtblk request during crypto
>     I/O.
> 
>   2. virtio_blk implements blk_crypto_ll_ops interfaces, excluding program
>      key and evict key interfaces.
> 
>      The guest's block crypto profile doesn't manage keyslot for the guest,
>      the host's block crypto profile manages keyslot for both the guest and
>      the host. The trigger of key programming operation is moved from the
>      guest to the host.
> 
>        - The whole block crypto key (key size, key bytes, blk_crypto_config)
>          and DUN are appended to the virtblk request during IO, a little
>          high payload.
> 
>          The backend parses the crypto message in the virtio queue and
>          construct a block crypto key and DUN for the bio_crypto_ctx
>          set to the BIO. So that the IO flow in the host can program
>          the key. 
> 
>          The question is that the blk-crypto-profile distinguishs the
>          block crypto key via the key's address. But the host has
>          different key addresses for the programming and eviction key
>          operations of the same block crypto key from GVM, because the
>          key is re-constructed in the host for the key program and
>          eviction operations. 
> 
>          To fix it, the approach I thought is maintaining a new key
>          hash table in the backend, and comparing the block crypto key
>          content and DUN parsed from virtio queue with that in the key
>          hash table. 
>          My major concern is that this need keep the keys synchronization
>          b/w this new hash table and the blk-crypto-profile's hash table
>          carefully, avoiding that key is still present in the
>          blk-crypto-profile's hash table, but removed in backend hash
>          table. Another point is that the whole block crypto key and
>          DUN are appended into virtio block request per crypto I/O.
> 
>        - For key eviction, adding a key eviction in blk IOCTLs allows
>          userspace client to evict a key in a key slot. I thought this
>          is a security concern.
> 

Do you have any suggestion about the key eviction operation? Could this
key eviction request triggered in QEMU be accepted? Would you please
help share insights about how to handle it?

Thanks a lot!

> 
>      This option doesn't need map virt_slot to physical one.
> 
> 
> Taking all the above into account, I made a compromise to implement
> blk_crypto_ll_ops interfaces in a out-of-band path, which lets the virtio
> blk only need focus on the data path. I agree that it is complex than
> the second option mentioned in the above, but small payload (only
> virt_slot, DUN, DUSize) in the virtio block request and no security
> risk of key eviction from userspace.
> 
> 
> I would like to hear your thoughts about the above and am appreciated
> if you could share your insights about the design of inline
> encryption in virtio block.
> 
> Regards,
> Linlin
> 
> 
> 

