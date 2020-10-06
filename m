Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F144BC4363D
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 14:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CA220782
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 14:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QcEEWTau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgJFOXq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 10:23:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgJFOXp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Oct 2020 10:23:45 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 096EIcZG001055;
        Tue, 6 Oct 2020 10:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : references :
 from : subject : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vQOCPBewiA6FWzam+o8RC12/OZVjNcljKnEsvtv+4uA=;
 b=QcEEWTausPgK1dN05qJAiFvkIieszGTWqWudCQotiBsPSqerqjf/coA6HdWBwnJvT5Q9
 sK3pPEXdqRVKp++bQfJcdbaw26NR14u9r/dhW4K4fLDlAWa6Ve4SIl/mfbLKUSWInjU4
 sMfEF7kdDS8nghb6LXR+y8gMZtp/LYxnWtUY6Y7y/saC8/IkUUAPuAkYMj2MabOLhCep
 xL2bM8FC0tbBW6NJynHbEQfqyQraAsFYbnn9pyDuv/2hJ3YGSZwPZXxRrZBgH5LAUOW8
 6k/s21vcdRCQ6TyOa6VrHTMl/FxgoEHnhnFTpdBZ4sLtlVgqiPfduNPCiGSYk6UWYj8I nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340rx9ug0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 10:23:43 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 096EIdqC001216;
        Tue, 6 Oct 2020 10:23:43 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340rx9ufvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 10:23:43 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 096ELRcA002439;
        Tue, 6 Oct 2020 14:23:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 33xgx81qdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 14:23:39 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 096ENaiC33489292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Oct 2020 14:23:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94286AE045;
        Tue,  6 Oct 2020 14:23:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FBBDAE053;
        Tue,  6 Oct 2020 14:23:36 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.48.160])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Oct 2020 14:23:36 +0000 (GMT)
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, vneethv@linux.vnet.ibm.com
References: <20201002193940.24012-1-sth@linux.ibm.com>
 <20201002193940.24012-2-sth@linux.ibm.com>
 <20201006114656.6b1a97b1.cohuck@redhat.com>
From:   Stefan Haberland <sth@linux.ibm.com>
Autocrypt: addr=sth@linux.ibm.com; keydata=
 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
 cH4TNHyhiR0KAbxE8qKx3Jc=
Subject: Re: [PATCH 01/10] s390/cio: Export information about
 Endpoint-Security Capability
Message-ID: <153dde83-0f87-69d4-df65-a43342f5fc8e@linux.ibm.com>
Date:   Tue, 6 Oct 2020 16:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006114656.6b1a97b1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-06_06:2020-10-06,2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060092
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

talked to Vineeth, here is his answer...

Am 06.10.20 um 11:46 schrieb Cornelia Huck:
> On Fri,  2 Oct 2020 21:39:31 +0200
> Stefan Haberland <sth@linux.ibm.com> wrote:
>
>> From: Sebastian Ott <sebott@linux.ibm.com>
>>
>> Add a new sysfs attribute 'esc' per chpid. This new attribute exports
>> the Endpoint-Security-Capability byte of channel-path description bloc=
k,
>> which could be 0-None, 1-Authentication, 2 and 3-Encryption.
>>
>> For example:
>> $ cat /sys/devices/css0/chp0.34/esc
>> 0
>>
>> Reference-ID: IO1812
>> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
>> [vneethv@linux.ibm.com: cleaned-up & modified description]
>> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
>> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
>> ---
>>  drivers/s390/cio/chp.c  | 15 +++++++++++++++
>>  drivers/s390/cio/chsc.h |  3 ++-
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
>> index dfcbe54591fb..8d0de6adcad0 100644
>> --- a/drivers/s390/cio/chp.c
>> +++ b/drivers/s390/cio/chp.c
>> @@ -384,6 +384,20 @@ static ssize_t chp_chid_external_show(struct devi=
ce *dev,
>>  }
>>  static DEVICE_ATTR(chid_external, 0444, chp_chid_external_show, NULL)=
;
>> =20
>> +static ssize_t chp_esc_show(struct device *dev,
>> +			    struct device_attribute *attr, char *buf)
>> +{
>> +	struct channel_path *chp =3D to_channelpath(dev);
>> +	ssize_t rc;
>> +
>> +	mutex_lock(&chp->lock);
>> +	rc =3D sprintf(buf, "%x\n", chp->desc_fmt1.esc);
> I'm wondering: Do we need to distinguish between '0' =3D=3D 'no esc, an=
d
> the hardware says so' and '0' =3D=3D 'the chsc to get that information =
is
> not supported'? I see that for the chid the code checks for a flag in
> desc_fmt1, and I indeed see that nothing is displayed for
> chid/chid_external when I run under QEMU.

ESC=3D=3D0 due to 'missing support for the required CHSC information' is
just another symptom of "unsupported" because the CSS firmware code
doesn't bring the required support.
Also, not sure if there is any flag/value which provide this
distinction. So we think having 2 different values "Unknown" and
"Unsupported" is not required in this scenario.

So, we kept a single "ESC=3D=3D0" which indicates "Unsupported", but as y=
ou
mentioned, in different levels.

>> +	mutex_unlock(&chp->lock);
>> +
>> +	return rc;
>> +}
>> +static DEVICE_ATTR(esc, 0444, chp_esc_show, NULL);
>> +
>>  static ssize_t util_string_read(struct file *filp, struct kobject *ko=
bj,
>>  				struct bin_attribute *attr, char *buf,
>>  				loff_t off, size_t count)
> (...)
>


