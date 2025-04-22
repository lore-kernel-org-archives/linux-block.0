Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC3C2147ED
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317620; cv=none; b=ag/EoC3A2CVcqSqNjCbRmsBBMtnpAHAP4s/gJkEdF3v5bEcJIboadAipQ78i3kfetz8l5z20bKLuNlIiuZiOcUjxYdy0vSFp55gRu7a45Il9UKkDfVZgIngo8RxPT05d/KRz9PVUgYE/aVqks/UzXinS4rShVJwbM35lziF+Pzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317620; c=relaxed/simple;
	bh=TP6OUJFhtDpr7kPIRj/YHBflpirtxlTLEgG1YWrHbXA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=QlGTFCw34uhsEeDz/O1ewFgE+iz7DL7vuXcQbxHKUmNW1l/0Rn2ztb8SJV9yYkAaiCM8g4SAt3VDxqrjcTBiJ0sQTNS7ezyow9VqU3OFYWhUQQp3pNUwF1SrQfrrvWJ48l/HwlvrcuXTe7CvWYCg/zAVir1NZdzu/wnSnkHCQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OAEz8Szm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OAEz8Szm"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MA9wvC028912;
	Tue, 22 Apr 2025 10:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5pDbgT4YLYtBfst2ft56evToL0Qgr+
	fdcQYJDA3pZH4=; b=OAEz8SzmX4A8aDzAcmLt8oj/yBw+oX2UFypjONCXpSMwN2
	qgPg1eroeMU5AoEBT9bvHJogtl7Zi4dovfbihqD0X+B8CcH1zshRxxV0EkI1gv5h
	FkR099U8Xj4mwjsx8JOlFNxqSd4TBKdXYqRRMTdPXwos0Ivp0OlGnubrX3Om/aIq
	E/tgiG70t/SM18rBTDPkcCGcyyiiKLSc0J5xtGo1LfesYZFuMOz3OcRy0ATV1MjF
	qgUB5pSJ4hvaFFo+cUesq+tpfi9YBtHm3EvzXf+km/OwCNiJmnQJKGW6sPiCcVqL
	J0Yl1/MhHj4KUfBzwiUGgGXjT4eQellOZ9O3eURQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 465x5vtkyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 10:26:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M8MdMl028188;
	Tue, 22 Apr 2025 10:26:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 464rv222s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 10:26:50 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53MAQnx741419482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 10:26:49 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD96858052;
	Tue, 22 Apr 2025 10:26:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E405258045;
	Tue, 22 Apr 2025 10:26:46 +0000 (GMT)
Received: from [9.43.46.43] (unknown [9.43.46.43])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Apr 2025 10:26:46 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------kX7WMegd2Yf5aT5EUqr02FYD"
Message-ID: <d2a484fd-3dbc-4bbd-9fec-642d0e44350b@linux.ibm.com>
Date: Tue, 22 Apr 2025 15:56:45 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 07/20] block: prevent adding/deleting disk during
 updating nr_hw_queues
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-8-ming.lei@redhat.com>
 <094c312a-38ec-4c5b-9db3-2269c37de36a@linux.ibm.com>
 <aAWv3NPtNIKKvJZc@fedora> <20250422070432.GB30990@lst.de>
 <aAdhbUAzFSxtCWzR@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aAdhbUAzFSxtCWzR@fedora>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 03Tq3Yx3PXOSPnXnNP0y5UO0qnFaoRl0
X-Proofpoint-ORIG-GUID: 03Tq3Yx3PXOSPnXnNP0y5UO0qnFaoRl0
X-Authority-Analysis: v=2.4 cv=CuO/cm4D c=1 sm=1 tr=0 ts=68076eeb cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=Es9Peie1KR2ZJdnpC0EA:9 a=QEXdDO2ut3YA:10 a=HbsX1NfKMNLhuVoUwIIA:9
 a=De_Ol2h6w80A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220075

This is a multi-part message in MIME format.
--------------kX7WMegd2Yf5aT5EUqr02FYD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/25 2:59 PM, Ming Lei wrote:
> On Tue, Apr 22, 2025 at 09:04:32AM +0200, Christoph Hellwig wrote:
>> On Mon, Apr 21, 2025 at 10:39:24AM +0800, Ming Lei wrote:
>>>> In my view, RCU is optimized for read-heavy workloads with:
>>>> - Non-blocking readers
>>>
>>> srcu allows blocking reader
>>
>> It does.  But it's certainly not optimized for long blocking readers.
>>
>>> Basically I agree with you that rwsem(instead of rwlock) should match with
>>> this case in theory, but I feel that rwsem is stronger than srcu from lock
>>> viewpoint, and we will add new dependency if rwsem is held inside
>>> ->store(), such as the following splat.
>>
>> How does manually implementing a reader/write lock using SRCU avoid
>> that dependency vs just hiding it?
>>
>> I'd rather sort this out as a rwsem is very natural her as Nilay pointed
>> out, and also avoids the whole giv up and retry pattern.
>  
> Thinking of further, the warning triggered from rwsem is false positive,
> because elevator switch can't happen until disk is added, and the splat
> can be avoided by switching to down_read_nested() in elevator_change(),
> which need to be nested too.
> 
> So looks fine to use rwsem.
> 
Instead of using down_read_nested() why can't we move the reader-lock 
inside elv_iosched_store() ?

With your patchset, now elevator_change() is called from three places:
- elevator_set_default
- elevator_set_none
- elv_iosched_store

As both elevator_set_default and elevator_set_none should run holding
reader-lock, I think we should remove reader-lock from  elevator_change and 
move it inside elv_iosched_store.

In fact, I just quickly prototyped rwsem replacing srcu on top of your 
changes and ran blktests. The rwsem changes sustain blktests and I didn't
encounter any lockdep splat. For reference, attached my (quick) prototype
changes.

Thanks,
--Nilay

--------------kX7WMegd2Yf5aT5EUqr02FYD
Content-Type: text/x-patch; charset=UTF-8; name="tag-set-rwsem.diff"
Content-Disposition: attachment; filename="tag-set-rwsem.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMKaW5kZXggNWM5
ZjczOTFhZjkyLi5iYmUzZGQ0MGYxZTggMTAwNjQ0Ci0tLSBhL2Jsb2NrL2Jsay1tcS5jCisr
KyBiL2Jsb2NrL2Jsay1tcS5jCkBAIC00NzczLDE4ICs0NzczLDE0IEBAIGludCBibGtfbXFf
YWxsb2NfdGFnX3NldChzdHJ1Y3QgYmxrX21xX3RhZ19zZXQgKnNldCkKIAkJCWdvdG8gb3V0
X2ZyZWVfc3JjdTsKIAl9CiAKLQltdXRleF9pbml0KCZzZXQtPnVwZGF0ZV9ucl9od3FfbG9j
ayk7Ci0JaW5pdF93YWl0cXVldWVfaGVhZCgmc2V0LT51cGRhdGVfbnJfaHdxX3dxKTsKLQly
ZXQgPSBpbml0X3NyY3Vfc3RydWN0KCZzZXQtPnVwZGF0ZV9ucl9od3Ffc3JjdSk7Ci0JaWYg
KHJldCkKLQkJZ290byBvdXRfY2xlYW51cF9zcmN1OworCWluaXRfcndzZW0oJnNldC0+dXBk
YXRlX25yX2h3cV9sb2NrKTsKIAogCXJldCA9IC1FTk9NRU07CiAJc2V0LT50YWdzID0ga2Nh
bGxvY19ub2RlKHNldC0+bnJfaHdfcXVldWVzLAogCQkJCSBzaXplb2Yoc3RydWN0IGJsa19t
cV90YWdzICopLCBHRlBfS0VSTkVMLAogCQkJCSBzZXQtPm51bWFfbm9kZSk7CiAJaWYgKCFz
ZXQtPnRhZ3MpCi0JCWdvdG8gb3V0X2NsZWFudXBfaHdxX3NyY3U7CisJCWdvdG8gb3V0X2Ns
ZWFudXBfc3JjdTsKIAogCWZvciAoaSA9IDA7IGkgPCBzZXQtPm5yX21hcHM7IGkrKykgewog
CQlzZXQtPm1hcFtpXS5tcV9tYXAgPSBrY2FsbG9jX25vZGUobnJfY3B1X2lkcywKQEAgLTQ4
MTMsOCArNDgwOSw2IEBAIGludCBibGtfbXFfYWxsb2NfdGFnX3NldChzdHJ1Y3QgYmxrX21x
X3RhZ19zZXQgKnNldCkKIAl9CiAJa2ZyZWUoc2V0LT50YWdzKTsKIAlzZXQtPnRhZ3MgPSBO
VUxMOwotb3V0X2NsZWFudXBfaHdxX3NyY3U6Ci0JY2xlYW51cF9zcmN1X3N0cnVjdCgmc2V0
LT51cGRhdGVfbnJfaHdxX3NyY3UpOwogb3V0X2NsZWFudXBfc3JjdToKIAlpZiAoc2V0LT5m
bGFncyAmIEJMS19NUV9GX0JMT0NLSU5HKQogCQljbGVhbnVwX3NyY3Vfc3RydWN0KHNldC0+
c3JjdSk7CkBAIC01MDA3LDIxICs1MDAxLDE2IEBAIHN0YXRpYyB2b2lkIF9fYmxrX21xX3Vw
ZGF0ZV9ucl9od19xdWV1ZXMoc3RydWN0IGJsa19tcV90YWdfc2V0ICpzZXQsCiAKIHZvaWQg
YmxrX21xX3VwZGF0ZV9ucl9od19xdWV1ZXMoc3RydWN0IGJsa19tcV90YWdfc2V0ICpzZXQs
IGludCBucl9od19xdWV1ZXMpCiB7Ci0JbXV0ZXhfbG9jaygmc2V0LT51cGRhdGVfbnJfaHdx
X2xvY2spOworCWRvd25fd3JpdGUoJnNldC0+dXBkYXRlX25yX2h3cV9sb2NrKTsKIAkvKgog
CSAqIE1hcmsgdXMgaW4gdXBkYXRpbmcgbnJfaHdfcXVldWVzIGZvciBwcmV2ZW50aW5nIHJl
YWRlciBvZgogCSAqIG5yX2h3X3F1ZXVlcywgc3VjaCBhcyBhZGRpbmcvZGVsZXRpbmcgZGlz
ay4KIAkgKi8KLQlzZXQtPnVwZGF0aW5nX25yX2h3cSA9IHRydWU7Ci0Jc3luY2hyb25pemVf
c3JjdSgmc2V0LT51cGRhdGVfbnJfaHdxX3NyY3UpOwotCiAJbXV0ZXhfbG9jaygmc2V0LT50
YWdfbGlzdF9sb2NrKTsKIAlfX2Jsa19tcV91cGRhdGVfbnJfaHdfcXVldWVzKHNldCwgbnJf
aHdfcXVldWVzKTsKIAltdXRleF91bmxvY2soJnNldC0+dGFnX2xpc3RfbG9jayk7CiAKLQlz
ZXQtPnVwZGF0aW5nX25yX2h3cSA9IGZhbHNlOwotCXdha2VfdXBfYWxsKCZzZXQtPnVwZGF0
ZV9ucl9od3Ffd3EpOwotCW11dGV4X3VubG9jaygmc2V0LT51cGRhdGVfbnJfaHdxX2xvY2sp
OworCXVwX3dyaXRlKCZzZXQtPnVwZGF0ZV9ucl9od3FfbG9jayk7CiB9CiBFWFBPUlRfU1lN
Qk9MX0dQTChibGtfbXFfdXBkYXRlX25yX2h3X3F1ZXVlcyk7CiAKZGlmZiAtLWdpdCBhL2Js
b2NrL2VsZXZhdG9yLmMgYi9ibG9jay9lbGV2YXRvci5jCmluZGV4IDM3ODU1M2ZjZTVkOC4u
NjkxOTNkMDRmZmZhIDEwMDY0NAotLS0gYS9ibG9jay9lbGV2YXRvci5jCisrKyBiL2Jsb2Nr
L2VsZXZhdG9yLmMKQEAgLTc0MywxNSArNzQzLDggQEAgaW50IF9fZWxldmF0b3JfY2hhbmdl
KHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLCBzdHJ1Y3QgZWx2X2NoYW5nZV9jdHggKmN0eCkK
IHN0YXRpYyBpbnQgZWxldmF0b3JfY2hhbmdlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLAog
CQkJICAgc3RydWN0IGVsdl9jaGFuZ2VfY3R4ICpjdHgpCiB7Ci0Jc3RydWN0IGJsa19tcV90
YWdfc2V0ICpzZXQgPSBxLT50YWdfc2V0OwogCXVuc2lnbmVkIGludCBtZW1mbGFnczsKLQlp
bnQgcmV0LCBpZHg7Ci0KLQlpZHggPSBzcmN1X3JlYWRfbG9jaygmc2V0LT51cGRhdGVfbnJf
aHdxX3NyY3UpOwotCWlmIChzZXQtPnVwZGF0aW5nX25yX2h3cSkgewotCQlyZXQgPSAtRUJV
U1k7Ci0JCWdvdG8gZXhpdDsKLQl9CisJaW50IHJldDsKIAogCW1lbWZsYWdzID0gYmxrX21x
X2ZyZWV6ZV9xdWV1ZShxKTsKIAkvKgpAQCAtNzcxLDggKzc2NCw2IEBAIHN0YXRpYyBpbnQg
ZWxldmF0b3JfY2hhbmdlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLAogCWlmICghcmV0KQog
CQlyZXQgPSBlbGV2YXRvcl9jaGFuZ2VfZG9uZShxLCBjdHgpOwogCi1leGl0OgotCXNyY3Vf
cmVhZF91bmxvY2soJnNldC0+dXBkYXRlX25yX2h3cV9zcmN1LCBpZHgpOwogCXJldHVybiBy
ZXQ7CiB9CiAKQEAgLTc5Miw2ICs3ODMsNyBAQCBzc2l6ZV90IGVsdl9pb3NjaGVkX3N0b3Jl
KHN0cnVjdCBnZW5kaXNrICpkaXNrLCBjb25zdCBjaGFyICpidWYsCiAJCQkgIHNpemVfdCBj
b3VudCkKIHsKIAlzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSA9IGRpc2stPnF1ZXVlOworCXN0
cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0ID0gcS0+dGFnX3NldDsKIAljaGFyIGVsZXZhdG9y
X25hbWVbRUxWX05BTUVfTUFYXTsKIAlzdHJ1Y3QgZWx2X2NoYW5nZV9jdHggY3R4ID0gewog
CQkudWV2ZW50ID0gdHJ1ZSwKQEAgLTgwOCw5ICs4MDAsMTIgQEAgc3NpemVfdCBlbHZfaW9z
Y2hlZF9zdG9yZShzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgY29uc3QgY2hhciAqYnVmLAogCiAJ
ZWx2X2lvc2NoZWRfbG9hZF9tb2R1bGUoY3R4Lm5hbWUpOwogCisJZG93bl9yZWFkKCZzZXQt
PnVwZGF0ZV9ucl9od3FfbG9jayk7CiAJcmV0ID0gZWxldmF0b3JfY2hhbmdlKHEsICZjdHgp
OwogCWlmICghcmV0KQogCQlyZXQgPSBjb3VudDsKKwl1cF9yZWFkKCZzZXQtPnVwZGF0ZV9u
cl9od3FfbG9jayk7CisKIAlyZXR1cm4gcmV0OwogfQogCmRpZmYgLS1naXQgYS9ibG9jay9n
ZW5oZC5jIGIvYmxvY2svZ2VuaGQuYwppbmRleCBkZTIyN2FhOTIzZWQuLjM1OWE1NWJmNDdj
ZSAxMDA2NDQKLS0tIGEvYmxvY2svZ2VuaGQuYworKysgYi9ibG9jay9nZW5oZC5jCkBAIC00
MDcsMTkgKzQwNywxMiBAQCBzdGF0aWMgaW50IHJldHJ5X29uX3VwZGF0aW5nX25yX2h3cShz
dHJ1Y3QgZ2VuZGlza19kYXRhICpkYXRhLAogCiAJc2V0ID0gZGlzay0+cXVldWUtPnRhZ19z
ZXQ7CiAJZG8gewotCQlpbnQgaWR4LCByZXQ7CisJCWludCByZXQ7CiAKLQkJaWR4ID0gc3Jj
dV9yZWFkX2xvY2soJnNldC0+dXBkYXRlX25yX2h3cV9zcmN1KTsKLQkJaWYgKHNldC0+dXBk
YXRpbmdfbnJfaHdxKSB7Ci0JCQlzcmN1X3JlYWRfdW5sb2NrKCZzZXQtPnVwZGF0ZV9ucl9o
d3Ffc3JjdSwgaWR4KTsKLQkJCWdvdG8gd2FpdDsKLQkJfQorCQlkb3duX3JlYWQoJnNldC0+
dXBkYXRlX25yX2h3cV9sb2NrKTsKIAkJcmV0ID0gY2IoZGF0YSk7Ci0JCXNyY3VfcmVhZF91
bmxvY2soJnNldC0+dXBkYXRlX25yX2h3cV9zcmN1LCBpZHgpOworCQl1cF9yZWFkKCZzZXQt
PnVwZGF0ZV9ucl9od3FfbG9jayk7CiAJCXJldHVybiByZXQ7Ci0gd2FpdDoKLQkJd2FpdF9l
dmVudF9pbnRlcnJ1cHRpYmxlKHNldC0+dXBkYXRlX25yX2h3cV93cSwKLQkJCQkhc2V0LT51
cGRhdGluZ19ucl9od3EpOwogCX0gd2hpbGUgKHRydWUpOwogfQogCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2Jsay1tcS5oIGIvaW5jbHVkZS9saW51eC9ibGstbXEuaAppbmRleCBh
ZmU3NmRjZmFhM2MuLmVmODRkNTMwOTVhNiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9i
bGstbXEuaAorKysgYi9pbmNsdWRlL2xpbnV4L2Jsay1tcS5oCkBAIC05LDYgKzksNyBAQAog
I2luY2x1ZGUgPGxpbnV4L3ByZWZldGNoLmg+CiAjaW5jbHVkZSA8bGludXgvc3JjdS5oPgog
I2luY2x1ZGUgPGxpbnV4L3J3X2hpbnQuaD4KKyNpbmNsdWRlIDxsaW51eC9yd3NlbS5oPgog
CiBzdHJ1Y3QgYmxrX21xX3RhZ3M7CiBzdHJ1Y3QgYmxrX2ZsdXNoX3F1ZXVlOwpAQCAtNTI4
LDEwICs1MjksNyBAQCBzdHJ1Y3QgYmxrX21xX3RhZ19zZXQgewogCXN0cnVjdCBsaXN0X2hl
YWQJdGFnX2xpc3Q7CiAJc3RydWN0IHNyY3Vfc3RydWN0CSpzcmN1OwogCi0JYm9vbAkJCXVw
ZGF0aW5nX25yX2h3cTsKLQlzdHJ1Y3QgbXV0ZXgJCXVwZGF0ZV9ucl9od3FfbG9jazsKLQlz
dHJ1Y3Qgc3JjdV9zdHJ1Y3QJdXBkYXRlX25yX2h3cV9zcmN1OwotCXdhaXRfcXVldWVfaGVh
ZF90CXVwZGF0ZV9ucl9od3Ffd3E7CisJc3RydWN0IHJ3X3NlbWFwaG9yZQl1cGRhdGVfbnJf
aHdxX2xvY2s7CiB9OwogCiAvKioK

--------------kX7WMegd2Yf5aT5EUqr02FYD--

