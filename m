Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F48C1F
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788826189; cv=none; b=DShPJjZd8ZmVX8FIsYvckKChyAKDT4bVT2+i6SlYnbTVZoxrbvdQYQ7yD99iOrFQRIS+fAvuPJOzFvisXt7ReQbVQr5vktccru32wf6xrDYz3J5GQKad2wxPw4skizGuZhzZCQay7Iy7uWvEyK8zwiyXBmeh/M4yW4GqxFK1x4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788826189; c=relaxed/simple;
	bh=ktaRgO8n331ZGXDo1yfMqYUgvwCnFoQw1Q263EpUcjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9pDA6M1sozYpwYBv9yN3ISFNW0y5A0MyB0KoEh+DQc/N7E6dqxDzVsQiQrHOKpaKA8gGCYOLtpE3wEXJI6ZW8z7ElirZzjWA6rijaDhVVYVjibCmNaqiMtbMX5405lvDlH/I5oNghJFJVHcUea5Jj2IzSPZpDqn9BQPDTW8CUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=JMOxRXjM; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=NZclfHQJ; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="JMOxRXjM";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="NZclfHQJ"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687MYBM63451120
	for <linux-block@vger.kernel.org>; Mon, 7 Sep 2026 20:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=NApM
	Mm5PQUWhUVgHzcWxZ/ang/AkF4VwG4La+zibEII=; b=JMOxRXjMS9mRfWfHZ9W+
	FqajNcj7FSX0ZswFOjzNf7ASdl8Y2hznx2a1cVEAmqvIv91W8NUQR0hNc+Scj3UM
	aGK0/LJ6gbQX7/0WRJ1G8uLJyNLtSvNwwcDFJyUpnTZVLRxWtcATD1KR5NGEeJWK
	ee1hjIMutZYqBlV4ZUlTf5cfdFuTbbxvjMZZrIDJgNksFutUQtO2LHiGyp5aFbFY
	hY2+uhje9RKKWBVbU7lwFMDka6j8PD5a4PdtrCOP5vWavD78avm8eDWzm5kKBFen
	hrmbMqwXV82IESRftCoX6vYjKzZM2iqFRDVQ0F70OclK7GB2XBKn7Wv8x/FKuXpR
	7Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gj4y98pps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 20:09:39 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52fb6c7b680so53262391cf.1
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 17:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788826179; x=1789430979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NApMMm5PQUWhUVgHzcWxZ/ang/AkF4VwG4La+zibEII=;
        b=NZclfHQJs/Xtmd7B3THUtRtA3dM79tLHiuG5d4FDb2RKanehxcGR6zpk12z53rhX+s
         C7QWJyIEaEyNNDmLxNFvu3gh5IPdaYGlQpCZHxiKQBY1w79jjI9sFKHgrVoJQFfo4DE5
         v4kT0PrtD9R3vmrEHJItntuTv1565giw55Z/wPxQxofRwfpoayrWscWRKf/C5Igeqij6
         /C0Okd39oAN2JYWdPgz/HGEfYj3cBI+eelaNdca8Ov/JqsdY1AFvCToEPgjdfy1nj5pn
         T415REZuYtQksDMa1hoSbg1xUFeCcdmwlVZhqWvPpg4Bz8iMRe2iVIi2b76yXeprr+gL
         GAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788826179; x=1789430979;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NApMMm5PQUWhUVgHzcWxZ/ang/AkF4VwG4La+zibEII=;
        b=CfXj0rBu5GrGEA9JOJuWXJFfO8kOK4A0jjajzt0eRt9MxJ665WD5hedD6A1IyMinmr
         X7eSEbtbKupwQF4mzO1nmuOmv4gqmHfItvrXVk5E4v7bsi97+TAw8F+dCgy/ssAr7uvu
         dMnvD8wG0acAdop1KSIVZumC5GAqi+PAjek2W7Ybca6xQbZyqAtnpxTiro1Nc4SXNasW
         6nYEiiK7XFXg6oY60Vnf6I+bVb9xitoKjcTYygOJhsq8NuUwHpsPAxco6AGekWdmlkvu
         X4ff0haV74JouqS8HUMmZLYbljuaJnTvRiBCFL5Jk5PNlfRVeA9q+fvnePubPJFOcRxw
         3aLQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+Y4LLUA/LIZ4sJHGtULtV4yxQOI6thcO7bVWH7HPPJNCR+h5fgQ1mGrhFjt+r4oUaqu3GtCBIxHXMkw==@vger.kernel.org
X-Gm-Message-State: AFuF++kfD1eaByJ7zEmyevPk6tScGLfeX70EBz5X6bS3z/feasG4cZPE
	MDThMI0liigFZKCq5dLAMasN/nqH51CsfAd87IxR1YAyw38kkiHMGmqgzAl0FuiELgyBA48+lj4
	ZS34uyGCwzMxLgjYXFc6s3lk+nXozDbpN4WYZ+W0svpH46hnzamVQgjzSWFhZ
X-Gm-Gg: AYBFou13G7dANug568TyyyvbCgeXNCeop6/yWbwYVsxJRL0I7WqMocReINF/rzK+CYn
	TwyD+PWVfrwnhpddz3KLXlLggb47tG2vrsfUlJQ2HgvIGM4TUSHisql6fpeBK8+sOpsik4pOtTg
	H9ismOT06PCRcuLy6DLv24LPajS0kuK1ok35zyqw0FOaj/mFYO6sKemD0NJYnNMTfTruIBdrARy
	lpuPYb5kXt2s8ad3grfrJkhtZzC22sI24Ia6zIbkeCFZkJwOv75CGpSCkS8E9RUbJntIgW0ky/Z
	LXaXs9Zi+PgDe//LQn1/vY2FaVIReGIENDelscslrlWE1OAMlBsYDBcZ5sn2shKJ8jmw8LBuHnI
	gx+o0PXqIDBgJAe6OjuSU5tNetGm2lHDg17e+YFgq8WGpVFw=
X-Received: by 2002:a05:622a:130c:b0:52f:e60e:70c3 with SMTP id d75a77b69052e-53054961fddmr291664411cf.24.1788826178623;
        Mon, 07 Sep 2026 17:09:38 -0700 (PDT)
X-Received: by 2002:a05:622a:130c:b0:52f:e60e:70c3 with SMTP id d75a77b69052e-53054961fddmr291662811cf.24.1788826176813;
        Mon, 07 Sep 2026 17:09:36 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-176-3.net.columbia.edu. [128.59.176.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305418950fsm98215411cf.20.2026.09.07.17.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 17:09:36 -0700 (PDT)
Message-ID: <c0165cc5-1763-42dc-95a2-516b47c53035@columbia.edu>
Date: Mon, 7 Sep 2026 20:09:35 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] block: honor IOCB_NOWAIT in the block device
 buffered read path
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner
 <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
 <20260828-blkdev-fixes-v2-4-32f3f40cebed@columbia.edu>
 <20260907071120.GC934@lst.de>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260907071120.GC934@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDI2NiBTYWx0ZWRfX6afrDhxNd0Od
 3gRS9jZLGX/dWGEE1Tuz0mUNmgNsvcI2IsoALNIozJ2xjIhFsJ2Y50RWhNEH9JGBpk3bWx4+jBj
 lOc1nSJcSfsu6P5OVE82wWUVkZatFeLz3/JYmDtnTKwyWRCLx2kwBIH+UVWDe/JPzFxa2YnjF8N
 LWn02+VtZOgb3+A+WVw2/UnGJKuDIkRohRE9onYsp8Z0uRMNSbH/gVTxuJlsb6to2Ld/Ktc7LQP
 PJa4JZG6RqQ2oihmMMwanjMFZfuWwsXdhznRmKCjPZabhhcnPgqg5G/6qiccrldomPEkQteYbI9
 LR96q6WzbacsuMhKIvU2xtMnfgk5pqSdQfxu5zcrnZnJ1gCv1vSS9K1B5b8WIHEnaZJxTji5jpK
 xn6hXLrD0CGIVYhSric/4tpLTVYZd74TsnNbJeieXQaWlt5kmx1SScOXG0jc99K5XK9s/KESuNr
 4mutbIL0GtNxsazyprA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDI2NiBTYWx0ZWRfX5pxPzn/4f7ct
 PbhRkKT+R5SXiycNWygOcaYMuN9TI469rzGOKDIyKG4hG0ve4sLUgE0bAq4xR7bSKJVBtk8gRew
 Umf6R3omuOGwZLD/xS/lklhR7sZU9HO15qWm74zFU4ZQlloDWPl4
X-Proofpoint-GUID: oDV7xpNfoHka5-ZxcBEVAOD87lj0JUtk
X-Proofpoint-ORIG-GUID: oDV7xpNfoHka5-ZxcBEVAOD87lj0JUtk
X-Authority-Analysis: v=2.4 cv=J66aKgnS c=1 sm=1 tr=0 ts=6a9f5243 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=92j1mJcILCjWExuphHMrQw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=Ip84Y9BoNSkx-ca77UQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11899
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=10 suspectscore=0 impostorscore=10
 adultscore=0 lowpriorityscore=10 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070266

On 9/7/26 10:11 AM, Christoph Hellwig wrote:
>> +	if (iocb->ki_flags & IOCB_NOWAIT) {
>> +		if (!inode_trylock_shared(bd_inode)) {
>> +			if (!ret)
>> +				ret = -EAGAIN;
>> +			goto reexpand;
>> +		}
>> +	} else {
>> +		inode_lock_shared(bd_inode);
>> +	}
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Do we want something like kiocb_inode_lock/kiocb_inode_lock_shared helper
> to better encapsulate this pattern?
> 

Seems like it's fairly common (~16 instances). I can do that eventually as
a follow-up.

Thanks,
Tal
