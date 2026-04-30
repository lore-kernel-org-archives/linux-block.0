Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B107E3A3816
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540900; cv=none; b=tKBy1wBMyfLyZUTkqAHpheZOLVkty0K72+EDDeYrD4KzmXqiFMfBt/eykRG3jfn60IR865n2anOr7OOXw3VznHQDSN7ZYPpQLh0+zRDDOOMoauZDAdKGpLESXgEgsTu9ygKI8Ni5vdx+enRAKCOd4xdSR81MLEG/3cfITDoQzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540900; c=relaxed/simple;
	bh=5VbGrAjbaukprpJqt2wW7jnukrcStD38ZA9lfHMjQ7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asIVw1YbKLPbvC5qZL7SRdw+p29BQEQHc+IPBG0zmXWz/KbJ69anTDHEP6PEtUaKKqlYDhJ+yhuGq8Ws8P6lS0Ek2rpnHurQCbIW/chCDiyJquL5SJsCY2SkGzxmFHDhMU1kOSMwdrLO53Ajb/A3684c/iW0w/5639Zk+/61BDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BLzIlbwn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZR3YlaR5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BLzIlbwn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZR3YlaR5"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U5pFac3992962
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o1WNaMKL0REcbyyi9G+CV0fM9H39t5QBIQfH9Xvc+Vg=; b=BLzIlbwnQ05OHk82
	LMkyessnHkjifiel+N3dItvb62jlZuUCmQ3jkSTwM2UtQm8OZ2QAnMtbIFdHYCKP
	J3oA+Ly273tzT1F9635jWua9o4VSh9wEiqu5gPYgWhSQVhcdYIde9Lz371Y7j63E
	tFa4XUHxVcxEqOt1mcVmNZ8zDrU/Bu4J+ztSje+nshOZ2fucjww6BZbdDx3h93RV
	p9M2sVminOXNt5vtO0guuJdVaIubZDnIbGK5CG9mz5GNwFnYIpy04CR0BXRewKUb
	/jSXm2E1bRFOm04Ikzw3MiGw25D6m/1DDxkrw5RMBV87+Yl6kI7MG50Q2d+tP5+/
	YNT1tg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duhx945tv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 09:21:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2d889997495so2645536eec.0
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777540897; x=1778145697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1WNaMKL0REcbyyi9G+CV0fM9H39t5QBIQfH9Xvc+Vg=;
        b=ZR3YlaR5jM1lsSIuquKYxDwzGL0jkqFGYXRtidFnAvjI8E8vWztQ4yjhbOOF5HYdVW
         QswHWYTReIhIPhJjbhmwep4QRB2bP1jNeUD7AsbbUt8YzCUxSfirioRiWvOc6JTyLZWY
         2abG8a+Ee0LKcmmmgKyN0N6NsnYqkHszdi7xdC70yMRpeh8j6hM6Zd9dWSRkOYK+hH62
         J7M5G3qMXbPyMSaozgf0SyW3K/KljRK24LjVF7AjXucWO1JwUk4bJZgiX+HNlkapNdJW
         muVgdjz5be3MCWPIcrE8eY98j7yTH/Eb/ml+R34UiFc/orfKXEtTIts5i8/NCDmdkcCS
         Oomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777540897; x=1778145697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1WNaMKL0REcbyyi9G+CV0fM9H39t5QBIQfH9Xvc+Vg=;
        b=K5ukeouh71q5Povn+OrqIjlflRiEsClbEp9MxrUFoe+eq1rfsiAhpeFTl3+es2cpKh
         V3y5kYFUgNAZRsEruzV0uhO+n+LpkFc1B7SfxZH6w6U8kpqVkKu5PX91CLAFP/RLnsHe
         jzLZupmINeKXMbim/sEGNIk3s7BeFL7Y9muxWOpbxekGsdNVGnX0Ih6cUn/Uy4+WT3LZ
         SmujocR29nnPS8mHll21brA3BuTD5eq6tmcJekLM+znpEuyUCx/WhYqXz9iilx3Mad0I
         UNPAveljuPeDjQ0wAqzw7C4HSzwq14/AOhW0u0oJuJxN5rlIT6QIFoI7swVYTZkUSdpj
         ZHdQ==
X-Gm-Message-State: AOJu0Yy+niOSm5M4dkAGHWuuFJ0atNftXi94M3sJK/rVa2aNu4fHnA08
	jqS05pn7zXaZF3R1AD7kRRblOzg0LI4XUL2eVB7KTs8CDpgRnLbj1qIBMaNo/4aMvuMae1RCY4J
	kcTtTo7sI++QZEcMWgFrF/U+WLlm1T56m4wlv3rLwtojTeclfkupwqvfqBuukV9bdAQ==
X-Gm-Gg: AeBDiesuw4VjOOudgOdt/c5mNSONkYwENvIvHW6UbCpQsJUhH3gLMtQYXpmtV4qDQgF
	pB4MLu6CEtSN3p84+xpwvIIIWlXR66Tg2bQFEnDBBOVL8jRhIManQUY6M0bSirqh1pgbQWn5idI
	+FeWikxIVFEDhoA/Rhw4/tI6rGa/gl+XWgOPtHxxHzNdGO0Jn5IiZhSP1wi22wXJTukWJDTgGh/
	ExsmNsBIMfW3doHPjT4hv0eKsM3PlwJMuf8e3Bj46a8BbVNxa7PhGt6W4KSv2kcwINjmc8fTVJ3
	pnw9pDz5iNUhJ3dj1CMkheCybQDV+9cktdOpbHvRr8FY2JAqiBwuTIA1sqeuviSz1WlKR7LL7dK
	CKOkiNUa69oC6di93Q9nKCdZKnIkFTpKleK8lY8//JEvbC1MZ2ypCE5KAVhSOD4pGB0DpasvJMQ
	uu9AVmH8/KcCM7JA==
X-Received: by 2002:a05:7300:7b95:b0:2c5:b23e:48a9 with SMTP id 5a478bee46e88-2ed3e491075mr988860eec.25.1777540897199;
        Thu, 30 Apr 2026 02:21:37 -0700 (PDT)
X-Received: by 2002:a05:7300:7b95:b0:2c5:b23e:48a9 with SMTP id 5a478bee46e88-2ed3e491075mr988838eec.25.1777540896448;
        Thu, 30 Apr 2026 02:21:36 -0700 (PDT)
Received: from [10.110.45.159] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c09c6e3sm5667943eec.25.2026.04.30.02.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 02:21:36 -0700 (PDT)
Message-ID: <effcf41f-c6a7-441d-85a5-b1d471611dfb@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 17:21:31 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dm-inlinecrypt: add target for inline block device
 encryption
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com, linux-kernel@vger.kernel.org,
        adrianvovk@gmail.com, dm-devel@lists.linux.dev,
        quic_mdalam@quicinc.com, israelr@nvidia.com, hch@infradead.org,
        axboe@kernel.dk
References: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
 <20260410134031.2880675-3-linlin.zhang@oss.qualcomm.com>
 <ae7yzw-5wz9cqZt8@redhat.com> <ae_vacHQ75AgZbm_@redhat.com>
 <6390db35-7f8e-4d00-9c1f-43d676007910@oss.qualcomm.com>
 <afDh8XRWW_JgaUP3@redhat.com>
 <7ab5cd97-30b7-42ca-80ce-6d9cd8c45b73@oss.qualcomm.com>
 <afIizQA9kVR_u_2j@redhat.com> <afIqszyKboCEmHDa@redhat.com>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <afIqszyKboCEmHDa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA5MyBTYWx0ZWRfX7lVmgWYnmkya
 /4M+kxAqXhtf8emHFCfmlfV6U6NqPYzuMhHKcHOMtUwOGP3c9kjARLqIgtyDDKkbOJuH2YCNmIs
 z6NeuxNt8DjGQvma3FGHTJd0fTO9DfTTc0TBEVkh3AGZ4VBg6H5hLqL63nMHh9vwnqkM2U8qTMs
 /wJhgvYOzeceLP/zgrEHbvIlRd8MTuLwMAsZK+kA+px0c9ewhr8byRR1g74zpCFDXhrqx2/cTM8
 /FCiZ4mbk2cTS0tRRlVVJIVrAGXM+JeIl8lXj1VcGlJg6kRaa/P/KaDIGJFSz9JG9OeHg+Arjp6
 TINkjr+cuktxJjU11w9JkP4WqaG0T/x7r8J+aWu7MzSP7avFf0x17FanXxc+0ellZRn3R+jYy4J
 ib/xGjskJuD6Ktk5C6/V7mVIeczxLIoGrBwwWrxHsLqXf6YK8b+MO/7aREtfeNy7jncUqWAX7xx
 0OtBjLlFLSMZ0iagFFg==
X-Proofpoint-ORIG-GUID: I10RdeS_EQxz_UM9fG8rmin41QTOO7-z
X-Authority-Analysis: v=2.4 cv=O5oJeh9W c=1 sm=1 tr=0 ts=69f31f22 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=lklvTEQ6XvIVcFA1PqMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: I10RdeS_EQxz_UM9fG8rmin41QTOO7-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300093



On 4/29/2026 11:58 PM, Benjamin Marzinski wrote:
> On Wed, Apr 29, 2026 at 11:25:04AM -0400, Benjamin Marzinski wrote:
>> On Wed, Apr 29, 2026 at 08:34:00PM +0800, Linlin Zhang wrote:
> [...]
>>>
>>> Thanks for the suggestions.
>>>
>>> Adding a bool need_acct parameter to __blk_crypto_submit_bio() would require
>>> updating all existing callers, which feels rather intrusive given that the
>>> accounting issue only affects the blk‑crypto fallback write slow‑path. I’m a
>>> bit concerned that this would broaden the scope of the change more than
>>> necessary for the problem at hand.
>>
>> I get your concern, and I'd like a second opinion on how much we should
>> care about this, but it doesn't look like there are many other callers
>> that would be effected here. The only existing caller of
>> __blk_crypto_submit_bio() is blk_crypto_submit_bio(), which would just
>> call it with "need_acct=true". Looking at the code path below
>> __blk_crypto_submit_bio() that would need to change for submitting the
>> bios:
>>
>> __blk_crypto_submit_bio() is the only caller of
>> blk_crypto_fallback_bio_prep()
>>
>> blk_crypto_fallback_bio_prep() is the only caller of
>> blk_crypto_fallback_encrypt_bio().
>>
>> blk_crypto_fallback_encrypt_bio() is the only caller of
>> __blk_crypto_fallback_encrypt_bio(), which is the function that would
>> need to choose between submit_bio() and submit_bio_noacct().
>>
>> Doing this would change the crypto API (by necessity, since we're adding
>> a new argument to __blk_crypto_submit_bio() for stacking devices to
>> use), and it is adds a extra argument to a number of functions, just to
>> handle this corner case. But it is still a relatively contained change.
> 
> Having discussed this a bit, I'm fine with leaving this as a TODO for
> now. If anyone wants to chime in with an opinion on how acceptable it
> would be to add a new bio flag for skipping accounting, that would be
> great.

Thanks, Ben.

I’d appreciate it if someone else could chime in on these two approaches.

> 
> -Ben 
> 

