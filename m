Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685771A8402
	for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734690229; cv=none; b=bYEuCYf8qoYlm8kXItyAm4A5fnEj0v7lfy9sC5IskuIWqVa2ksOj7O2iGeky3pnbtF0GJt+g3ZmIY12KoVdMhJdWHQ81UUmR0kD8kmxMj8HF6g16cuksWUy0v5wwjQo2ubnw0bEPjKAl2PDLMt8iOHRc1TT5iIACJ+yHgsqM4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734690229; c=relaxed/simple;
	bh=+1sSxMwAtWI4mZPXnC0JhJRkdwelr0l709Tfi+y1J+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AJPe30TcUwbMbXY8HyLHHt/N9DmjSb6iLM6frQzB6h3uyytY2Z+gnV6BXgectYbTUWo/CJn54JqnsVXdjbBvyGEs8pS1TUqAyDEU+JlxswPM+vEU+EjjEWvJn4Lc5lDh9zPTTqqEIq4iGcIDacRj4/jT7eoJ8jtF4ACbvxAlEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DMgfXxQA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DMgfXxQA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJNqrJa026584;
	Fri, 20 Dec 2024 10:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0ewdM1
	E9eKY6VcVf310KbT3MDVRQt4jV6Bs1ic1bXJI=; b=DMgfXxQAdVg9n59SXCApC9
	WD6EeMQx/U3UN9+nUX3poJbG14ZN30quaQLpmmG9OuGOv4NeGUqciDp3W0MjQ2x4
	A2WqHB4eyyQ2qM0s5zHO4RB9hY9EUlsflTMX/JFbk+qaCBTnXgQ9ZlF2Tr9ZGJZ7
	rAffDIng0o2Kafaknps2SPR53OBO6pi2bAQkZVB1Xju6lOBmUYbEQktMup6vVT30
	7Twi25BltAoepdjiT+sMdi4D48px7pE0NruWnWSNAL9bQ2uCQ5YcLyx3x6mj+1vK
	yyONJ1amP62kveb7IBr5Z3PwriOzQhWgM8HZEtqa47CTNlayOXlKOoR0EX8wN+2A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mmy5cq1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 10:23:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK9udX6005694;
	Fri, 20 Dec 2024 10:23:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbnhprc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 10:23:45 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BKANisb27525780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 10:23:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A65EB5805D;
	Fri, 20 Dec 2024 10:23:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6916958043;
	Fri, 20 Dec 2024 10:23:43 +0000 (GMT)
Received: from [9.171.21.204] (unknown [9.171.21.204])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Dec 2024 10:23:43 +0000 (GMT)
Message-ID: <23c3e917-9dd3-4a0f-8bf4-0a6f421aae0e@linux.ibm.com>
Date: Fri, 20 Dec 2024 15:53:42 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Revert "block: Fix potential deadlock while
 freezing queue and acquiring sysfs_lock"
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20241218101617.3275704-1-ming.lei@redhat.com>
 <20241218101617.3275704-2-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20241218101617.3275704-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wV1joTKYG8vygX815rMB9f2sW3shUhxY
X-Proofpoint-GUID: wV1joTKYG8vygX815rMB9f2sW3shUhxY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200082

On 12/18/24 15:46, Ming Lei wrote:
> This reverts commit be26ba96421ab0a8fa2055ccf7db7832a13c44d2.
> 
> Commit be26ba96421a ("block: Fix potential deadlock while freezing queue and
> acquiring sysfs_loc") actually reverts commit 22465bbac53c ("blk-mq: move cpuhp
> callback registering out of q->sysfs_lock"), and causes the original resctrl
> lockdep warning.
> 
> So revert it and we need to fix the issue in another way.
> 
Hi Ming,

Can we wait here for some more time before we revert this as this is
currently being discussed[1] and we don't know yet how we may fix it?

[1]https://lore.kernel.org/all/20241219061514.GA19575@lst.de/

Thanks,
--Nilay


