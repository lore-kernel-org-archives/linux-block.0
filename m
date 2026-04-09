Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147D31A065
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761160; cv=none; b=Sgb+EZXnCCaAB1nc2MYYuP+T6GgxRYTg59xG+sSx4nBGPkCxIdWBcQEavjazYgddy/xps7b3jPSKYMErNtDipwFbpISMLtfBDFYRLPZB/jPmXf5HidiSkI89wmgcMYqltDsmjX1ZNa/pYuHTTew3EOS1d8jRvC1AzcaorTyN6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761160; c=relaxed/simple;
	bh=83mNKZIsBND3Lg8+THcthV/SuzYcLTq1w+CNeg0fbZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pq7relgBRN3T7H/jVKRdzzSJLQhBsWou62raNyKFkhfaNPvhOF/apwfsL8brpVYhzIIHAoTTX/168/xLf5ToKSipQ3dJSPupv9l9mmRtnK/7CZ0aWCzJ0ewedMhdBvCoEge2MIpZ/vAYA1B0KTaKDC1JKvIzFaPJUsFaNyImUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=EHz3tC4l; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="EHz3tC4l"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639Iu5tA2341383
	for <linux-block@vger.kernel.org>; Thu, 9 Apr 2026 14:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=83mN
	KZIsBND3Lg8+THcthV/SuzYcLTq1w+CNeg0fbZc=; b=EHz3tC4lRgXai8PvPEZq
	pkKUs3OvD5nVT1jqwDXFpk6Rhe9R5SxV6b/feB3LGa6Ml2hWQWH9nTOnbI0jQzLo
	QLYJRGLVXQOHbFB1Vy36nqjvpb9IUyFleXcX5OznP1OtLhuMvp6uayzuz2W+yvxa
	bs5GuKsexDDUjrZp0lEwLGsyCESY+7+nHbIsv21ltQxArYbn0i1Bt/Bmp3jLurPn
	iki6jHLGtAFYO7D52XkMbj6PiglwXmCOboDjwVU3VjlwlhD1YByF+WvnaBhABguH
	kkai+Ec2gVbgexur9XaYmeywsRhFC5Ikw68louduoTGyWGonKSBQ7TCwkUGf3TYB
	lQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4decmrbat4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 14:59:18 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8a5f6110cadso38457676d6.3
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 11:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775761157; x=1776365957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83mNKZIsBND3Lg8+THcthV/SuzYcLTq1w+CNeg0fbZc=;
        b=RjI+FVjRv/BjwYyNdm5GYkjdFQz7M8xSSephdMSYuyYkFpjix76ZLzmPCFEohzmf/e
         zGZRrAT/TFntrQOWSG/ZzvXC3eT6nbq0AEEv4D7TiZhhhlfByefbW2PVfi/UFncEJvrg
         +fJMzzRanX3WYgd9Fl7IXTsN5E80hzm36DeAdhQj0FbQMiHlj83ul6G0xARhgc8H2eR3
         DvpU4SZ0Sd9DH3dvutfr6SnD6clxhcYj0AUPMhyktuaAeEHy7b9uMV4+s1gyDASZw7Uf
         D7p/upeThGlkQs2xMQnV8mweadu4zYAyaZftcxf1Xtt5LYB1MkJ+YfEzXpNYiQTUimjD
         fRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeYrHnuhcrtEGmPSDuMUfEg47jkMO5h+43LwHzkSdxJa0Hr7puV3RR+SOWhcTWCdQH9Qmcn8LCa8EZJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMq1g9Z0cf88XO6vTg8qlPTkgEJNP2EVRTLfQThcUOIXBAtkD
	cm2iAUCqLk1NZSgIWK4wjArhnW8T2Urgx2dm90sEPXB/JwZXMHZOB24tgisoZKegXGSGKrRnkSI
	FCh246BBqqSIPoiMLgiJzZ8IS3f7HmvOexw89WFjdZyswRVg7NJJYhOxjqz1d
X-Gm-Gg: AeBDieu15qa/qyWJw2kqXD2awS00ZL1mdbHbh9kYwl3KhOEA57F4aiV1Bb11qnCGdhF
	UBObMfHcjluU4MxTRa3xHEzcOIGP3eut1EDhrliHQcKDXG0aU4jEvAUbMaAtSN03+QQrc/RLkJs
	SiDgHUSTYNYIL9hiVFZK7Fgup6p785xpducQIRZDfkhFjY62cf0yo9X0wW9JTr/PbF49eWwdVbl
	secCfWBTmIUx605gC/KE3+K+mzZCdnCmKb73+u8jxSjRDqbZqOz28bl3+7aNax+hZcNlxBObnS0
	URnAHVKLFxExSUlEesRlFyge0cHFAO5apWbk9VoZeJs8PvIfFeIp4UZ3lxcuNxtxdD7ljF/Wenw
	FTXTcd4UEfcg/PVeHExumAW5Y88v/nkwi3w5wHwYD
X-Received: by 2002:a05:6214:44a1:b0:89c:bf90:e4ea with SMTP id 6a1803df08f44-8a7042f7e4amr439710386d6.34.1775761157306;
        Thu, 09 Apr 2026 11:59:17 -0700 (PDT)
X-Received: by 2002:a05:6214:44a1:b0:89c:bf90:e4ea with SMTP id 6a1803df08f44-8a7042f7e4amr439710016d6.34.1775761156904;
        Thu, 09 Apr 2026 11:59:16 -0700 (PDT)
Received: from [10.206.71.59] ([129.236.231.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849db735sm4286926d6.2.2026.04.09.11.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:59:16 -0700 (PDT)
Message-ID: <fdbb90a3-846f-4b55-b22a-5a8027bee288@columbia.edu>
Date: Thu, 9 Apr 2026 14:59:15 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 3/3] block: enable RWF_DONTCACHE for block devices
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20260408-blk-dontcache-v5-0-0f080c20a96f@columbia.edu>
 <20260408-blk-dontcache-v5-3-0f080c20a96f@columbia.edu>
 <adfPA0_U312XhCYF@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <adfPA0_U312XhCYF@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gQ5YOS1t0IGGLYl2rGPCQc4EdWNjVm6q
X-Proofpoint-GUID: gQ5YOS1t0IGGLYl2rGPCQc4EdWNjVm6q
X-Authority-Analysis: v=2.4 cv=UOft2ify c=1 sm=1 tr=0 ts=69d7f706 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=RFpAoTwO7tzpE9r8PTiuXw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=VtaHy3UVxHd-gCO4CH0A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3MyBTYWx0ZWRfXxuePjB/maHRf
 AOFO+w/8nzunn1bVHWlGfmj1TW9sBTvDtl8tNZ/pm961IRwIL6uH1RPnH0oIjaV2YcESLWmZsUi
 W4uNwQRrgGG4yQSeJ3kalbwExVid5dtNCuocp6NzW6ouWDY+MYGcydKBUvaPjv9mUsLfZ0o72uV
 9W/u1JEJ5QkxswF8nk9RAUgvZIq96QboufnHp9QY39SndeBTo3j5JLz6tSn9Av5iQL0bx0OQT7Z
 siDoHeTVLPrnPPBJgYdGzqrORiZAYcP4goihbkxw/N9arPYL2BEAi6Oy7LgWPIfufsAZr4gIO7k
 aNgF36iPPKHDGicIbyZwr0R5eDMJqRCsFjB8vTrgwf4ktw6CzUnSgGqv3O07e8uiGpEdYyMR+L2
 lYkLiQ34yrrqmJOEytn9AHN+1hu+j+YVmEOk90FZKrP32WO0/n6YdBU975B8R/QtByz7QKP3ojv
 umh6+bWRiKT3Wq8wz/w==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11754
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=10 priorityscore=1501 lowpriorityscore=10
 suspectscore=0 bulkscore=10 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090173

On 4/9/26 12:08 PM, Christoph Hellwig wrote:
> For the next round please split this into the buffer.c parts for
> the infrastructure and the use in the block device file operations.

Will do.
