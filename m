Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB01EC4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9C621531
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 14:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lhLrfUs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgJGOYO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:24:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728615AbgJGOYO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Oct 2020 10:24:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097E3N7q056300;
        Wed, 7 Oct 2020 10:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mbd4bPQGRnsNhALUsn0I58V1A7Ckoc7E5+Sg74/VykM=;
 b=lhLrfUs2HKvQQWUuDWATlXQEGh9Qjh8Vq1mGuXr5ZVSenhtmP8WGuGQzWFKBpV0beMw4
 D2rEtvgMFEjOPufqPJvGhLekA0VKfgaVOQYBYeWlgiQxjbROivRi249yKemDIIWn66FX
 vfoiy2HxXBoF97JVt8jWbBXqujedVxR8PSQ5atssDHypHfNQwcZJIrmL7f2lducKfq7P
 jzANOhTAI5CanaSAbSy3iRaB3MLThzD3GL1PV7MSk9quAprlP7GhilWFcx0Uwdplzzww
 65vX6VbrPJQOiTv9ppleU9x5wWG80+ORpTyRwABE1NtvhvnTY5SM2FGATKBSrvMoU/gm dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341efx26w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 10:24:13 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 097E3cuS057522;
        Wed, 7 Oct 2020 10:24:12 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341efx26v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 10:24:12 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 097ED1Cc010999;
        Wed, 7 Oct 2020 14:24:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 33xgx829ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 14:24:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 097EO6BE31785470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Oct 2020 14:24:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1B28A4064;
        Wed,  7 Oct 2020 14:24:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62450A406A;
        Wed,  7 Oct 2020 14:24:06 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.147.56])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Oct 2020 14:24:06 +0000 (GMT)
Subject: Re: [PATCH 02/10] s390/cio: Provide Endpoint-Security Mode per CU
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, vneethv@linux.ibm.com
References: <20201002193940.24012-1-sth@linux.ibm.com>
 <20201002193940.24012-3-sth@linux.ibm.com>
 <20201006164646.5b586679.cohuck@redhat.com>
From:   Stefan Haberland <sth@linux.ibm.com>
Autocrypt: addr=sth@linux.ibm.com; keydata=
 mQINBFtGVggBEADI1Lne1npTa+b5x5EJ7ka0siRMargCCo5dcOaCBBG3wT24IyyG6chdV7Yr
 vkeHDm/6OjMi+w8Vbx2ts0KhYWMj9SHX2E58AsyBedeCkedOKuhkNh0HNSv8WMCEi24uoYK9
 3VW0bQ3KYAB5wYQ/bONn05qSJ18Ev2Mqs1IOJdukJAM6dcJoUX2NigSiumGBB1SgJLHjbAFB
 lR0OUeFD1QOFF9vljOnTXhMeiDwRpJtKRN2z2FmqBKJl4hinBARd6JvHPZ+2OveTfyzj3acH
 LDfLETVMiBB0/iJGzFLrM7EcNdo2Cz9RhcPFDYJO9u5Oa9RcYlcBDngBi6q4dLwncABiM9hl
 0uiNfemxpEhIIEMh3GRfTDknAwQNRL+PWTE3K15YQ4O5Kk7ybwxrEjm0bKAso8GAXGTF5D7V
 NuoA/KYChCChG4Nr6mq7nqhO/Ooyn7KmchtdKlcs/OP8eidv3dfNHPAcesmzhc2YFf/+vxzH
 DJaAxiLmo+4jImghF3GUwGCK28Gm1yqDM/Zk9pTDV8iGrcz4L4U6XPjLJH6AHKdRViTEUPCC
 ZkuDh8sLwV7m1HWNTIatubYBokQqpcjxa1YIBF3vdn407vgv8AeKncVsWKFdUYCsbOKoJsiP
 21N1jo7OF7dzGOHeSecd/8NYbkSoNg9nfn4ro/v0ZqwMATVg7QARAQABtC1TdGVmYW4gSGFi
 ZXJsYW5kIDxzdGVmYW4uaGFiZXJsYW5kQGdtYWlsLmNvbT6JAj0EEwEIACcFAltGVggCGyMF
 CQlmAYAFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ9KmDAON4ldE6dhAAn+1T+31d8H+t
 yRJT+RiMatuvfxBm1aTEzV7GgLSfXJD9udecihxNgfEfT2gJI2HiDMCFeoetl4553D92zIB/
 Rnup0C3RH9mP+QDDdy35qGOgCtIVSBz9bFp/F8hm6Ab+DCnCJ8DpVzcB0YoAfDfwdEmh7Q8R
 317H2IAhlRP44kIJmzZ4WP6pzGSqlmy05wCepDgLiGF5Bc4YnDOoRlv2rGmKO6JET4Nbs4PR
 a5xiNE7AOnsu4bGRN2Rkj0kiwmkYEQLuPoDwr+ookbYRqCVHvkpv+yoyi87yY2xcfbpHasV0
 gFzy/AefjEe5PRfvAhyXeYS3O2PCWuxcKBqHQhHzJz9Kss/k8EGTwj5kxRVgaD6b9yh8dVfH
 hRjkzFCXtrm6zDn1OQnkvIYy04o7UYiYNdzXEBVTsB/JN7kFR/vH5vTR0nU7mEy39uq7Eazs
 SdiyXlA+3lvr6H+P3Kl5ef1wdlT+MZ9Ff/xeJl8p0uB/WsypmdZ5yiEHn7eFSuVsQDadGkh5
 aGchTuBteeHW7xiKQ1JdG+NSxHNnDgf5fB6yXZZPql9JYdcsRI5sQonlvfgRrjcNZ5GsG3Hl
 QHyzKELnDQJjazq7dwGn01WnJon4dcjIqoPm5gC8DKGKf32rWTTDZmEh3y7c4ZomDWPJ7q2l
 7rqS61Rjq5lmFSrR2LEmXCO5Ag0EW0ZWCAEQAOzd3SIx13tiseVIk+UtI6gsXEamyMbvfIk7
 aJ7UiVlDm/iqp8yU+TWxbNJWF+zvxzFCpmwsgmyy0FCXFEEtAseSNGJUHu9O9xsB1PKSM1+s
 UoL5vl42ldHOMpRnH31PObcq1J9PxBR8toDVnIGZLSFi0m+IgIYCCdpzLVlTN7BtvFWLJ42Y
 kq1KcQE8+OJYSbTP1rMk/GBYX3PBPw4y2efQeqkep3Bvx1DuauOl/PGPKi4xRpycIBYJSDRh
 zoDejB2mMWnm9FVwYKyRBef/PaOYc0FrZ/KlAZk15OaSc9ay14KMTDM2G+lUjBHojtuxt6LH
 zohXw2vqHIJ1zTCBzDY6R7Cssbasu73NoPYwPYUROkJcf/bhepSYa4lCWLWi/+z3UOS+VfhD
 p+b/JlfubyIcumkS+tVx5HMZC+0I4gRqeG/BxhCq7HANn6sRttyRvPUg+z0dRxlDm9evQbhu
 uIt8u6actq6gxGpa89I6gSscx1ojbY5H6+36FOGXN/FygY3EQ6cJ/Tz4hwOB85zA+Do27UnT
 tmqh6N6HlDLH0rFqDStGkU5p4bknHdvFOuiWaafomvSUBt7V3wMS5ST1UpogtLaK4jdEy0hx
 3mn6O084g01w6Y/rdWFVSWDh9oaQNmR7aeB8JDOklOPJCe0bBKFK0ZMF1Kz9AzFj/RFzWfB5
 ABEBAAGJAiUEGAEIAA8FAltGVggCGwwFCQlmAYAACgkQ9KmDAON4ldGPmA/+L3V5wkmWZJjD
 ZJIvio/wHMoqObEG6MxsFvGEoSDJBBGQ5oTiysACFM2vkOaOhj2Izh2L+dbuKJIT0Qus0hUJ
 uEjGgIAXn7hYNeM1MMqSA81NEoCeUhNHeZudf5WSoglG3rUnxIXrnxfDkn8Vd36cinGejyrI
 qJoydRMpX48I3wJcyvZ8+xgM/LLlvXEH4BpuJL+vQkefJrn0R2vxTnHcj5TE1tKNwhI7/343
 PNzhgHGYynjCbF4u9qpSqcJl/exFnRXaTH6POIbHXIRe8n4TfdXsOcbI3j/GUF0cXinkfxdt
 BWH5rC3Ng+EN3jkDo8N9qF7uEqN9rRaekqsO0jYMQJlfZeJSQH9KHD+wgZly9j6DmnGexbdB
 aJdzCtbIR+oJy0HjfwvIQrgp1pj0yvXeDsUHykATsORx0ZitlGUuU6tlAnbH346nNSDoklLI
 lEDvODTgpkhWDczM69MGKrFYgDcIqXZFWzea6Xq+cuGtGO5xV/4K+efWQovlIdv4mE4j2E2G
 yXj14Nuyh4wqdX9/yspSZCH1TCbXD9WEB5nQCQNAKzIB7YaTQBjFi1HFzGOGYteZGC37DJ6a
 xEMRG8/iNZSU4dSL+XsaTnUk5wzzSnz0QVOEOqRY5tkS3zpo9OUGevyR3R6bRqH3EaA5H1cS
 cH4TNHyhiR0KAbxE8qKx3Jc=
Message-ID: <3b721a6b-202e-d7e4-d4f2-2a3954f74609@linux.ibm.com>
Date:   Wed, 7 Oct 2020 16:24:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006164646.5b586679.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_09:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070089
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 06.10.20 um 16:46 schrieb Cornelia Huck:
> On Fri,  2 Oct 2020 21:39:32 +0200
> Stefan Haberland <sth@linux.ibm.com> wrote:
>
>> From: Vineeth Vijayan <vneethv@linux.ibm.com>
>>
>> Add an interface in the CIO layer to retrieve the information about the
>> Endpoint-Security Mode (ESM) of the specified CU. The ESM values are
>> defined as 0-None, 1-Authenticated or 2, 3-Encrypted.
>>
>> Reference-ID: IO1812
>> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
>> [vneethv@linux.ibm.com: cleaned-up and modified description]
>> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
>> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/cio.h |  1 +
>>  drivers/s390/cio/chsc.c     | 83 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 84 insertions(+)
>  
> (...)
>
>> +/**
>> + * chsc_scud() - Store control-unit description.
>> + * @cu:		number of the control-unit
>> + * @esm:	8 1-byte endpoint security mode values
>> + * @esm_valid:	validity mask for @esm
>> + *
>> + * Interface to retrieve information about the endpoint security
>> + * modes for up to 8 paths of a control unit.
>> + *
>> + * Returns 0 on success.
>> + */
>> +int chsc_scud(u16 cu, u64 *esm, u8 *esm_valid)
>> +{
>> +	struct chsc_scud *scud = chsc_page;
>> +	int ret;
>> +
> I'm wondering if it would make sense to check in the chsc
> characteristics whether that chsc is actually installed (if there's
> actually a bit for it, although I'd expect so). Some existing chscs
> check for bits in the characteristics, others don't. (Don't know
> whether QEMU is the only platform that doesn't provide this chsc.)

I don't see any benefit in checking upfront if the CHSC is supported -
we'll get
a corresponding CHSC response code and since no error message is logged
for this
case, the outcome would be the same as if we checked for the
characteristics bit
beforehand.


>> +	spin_lock_irq(&chsc_page_lock);
>> +	memset(chsc_page, 0, PAGE_SIZE);
>> +	scud->request.length = SCUD_REQ_LEN;
>> +	scud->request.code = SCUD_REQ_CMD;
>> +	scud->fmt = 0;
>> +	scud->cssid = 0;
>> +	scud->first_cu = cu;
>> +	scud->last_cu = cu;
>> +
>> +	ret = chsc(scud);
>> +	if (!ret)
>> +		ret = chsc_error_from_response(scud->response.code);
>> +
>> +	if (!ret && (scud->response.length <= 8 || scud->fmt_resp != 0
>> +			|| !(scud->cudb[0].flags & 0x80)
>> +			|| scud->cudb[0].cu != cu)) {
>> +
>> +		CIO_MSG_EVENT(2, "chsc: scud failed rc=%04x, L2=%04x "
>> +			"FMT=%04x, cudb.flags=%02x, cudb.cu=%04x",
>> +			scud->response.code, scud->response.length,
>> +			scud->fmt_resp, scud->cudb[0].flags, scud->cudb[0].cu);
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	if (ret)
>> +		goto out;
>> +
>> +	memcpy(esm, scud->cudb[0].esm, sizeof(*esm));
>> +	*esm_valid = scud->cudb[0].esm_valid;
>> +out:
>> +	spin_unlock_irq(&chsc_page_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(chsc_scud);

