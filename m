Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D142D6E58
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775688698; cv=none; b=V0fQb7wiwEOxO6exEtg/Uvoq7OGpDCL92WEomiozijFhwbvuwgqaKmiawySpvXToiRhPw+2rzvowZFSXYOSxGGI015eJvUZtWerbKNOwqpXEZHPiZHH2jyQZiSQIAhr0b5kae3A0pLkzmXsB/AdDcQ2YUfUEhTvoRUG2As6EXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775688698; c=relaxed/simple;
	bh=NP/NrnNRzZkpV1grdYgncLQy+kN+d6bh/MFF2s6ctT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oztnr5uAS3TfTHrAK4P4ZV2xXsAZhDtn87fH1pomsm5+ua1F7SU8vljkn1ned2+Std33ZY4nixzN41X2UuV8p9wu0vOpY7HoKfbpc3uSuz8MEWP9X2DzWd+PnVz7D+HATgu6pn/ltB6tIbC8qIEM7QzwjBTGk7Z93bDvMornsgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=iYLVepDS; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="iYLVepDS"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638Mg5K12658907
	for <linux-block@vger.kernel.org>; Wed, 8 Apr 2026 18:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=0HMT
	yjU+3VWME3neIOtWAUbmcTCr0jHyC7V9xVqa7uE=; b=iYLVepDS0lKOjgw+ZsdC
	ZWja2OTdpkfhNueRHpTof39JrY0XGw5tnXPdf8MWu7FTxzuJk1ppxGkISTR1zMwH
	zjK++sUyrla/vSpzgaHI8mCeaf7oelKQ2DsSDzEpYDFy0sBiv7GyYPjIlQlQ0xNa
	f94iycbv0Iwc7JlBKB4Z69n3gBmRaEplbtA3GkFBc0/EF80LNlS2CFtrEjseHD/2
	L1ndgJl5EST0f9oHbXarVMmhw9ub+TTHdIN5V8O6mhR0lretkp9PlaKbCmGkgmbp
	NoWaIr3WXzAG3qKJ/Cb82OrDBLMMiaHr10ys2DtT9AZpBvFuhP8jVx8vV/B+0AyG
	5g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3n8sbd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 18:51:35 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d890580e1so8720641cf.3
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 15:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775688695; x=1776293495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HMTyjU+3VWME3neIOtWAUbmcTCr0jHyC7V9xVqa7uE=;
        b=nJbN0Ii01GD483o13NwtZgGz+46mW20L6awk2eCX8xMm11UuyZR5l3cK6BFkw/mPCE
         YVgpxyrD7ORxJMg8ELn4YzMtJHFQK6yx4zNwjMCmiC7OCy/zjFxBrPxg44b+9yHo9AZB
         bMtN0BAKfhmstC+MMdPgbX+c3rRNe4koDxiZpQLu3efnJsIKZjRdVIWBcD3fe98yh42z
         rRqQlTWaZq17sDDh3/Ubcd5OAFu5lcXcLBviU8r2FzeFo7Dd1A25v3va3oRFN2LuCCFu
         rTRhIDgDNCqu99OPohSYMuappsU2XkYIG5YuhsoL9miPvqGyGyU6erURIhlSyJ8m00vm
         qvLw==
X-Forwarded-Encrypted: i=1; AJvYcCV+lHusCMSxnIV3mjd+dmZRT99brhpCSpuaHwEieVMrxipgeJddDV1ahs73Ig38VkwdqTaUSeGMnBrR4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcng3ql9yvf1Es+jv2XkibI9Ai8vy6qbNOOMkvvn0Vud95O6Mw
	8qA5VHsR5gkGfygZWprwhiiiUEt17lwvqILNPsNMYN1k5w7pd7mPtKwzWAxee7VMwc4m7+wNFkw
	sAJbTL3/WCIBAanXhol8jKUyRtBf2auTOscE9tymXnN+4ZVvsKc0iIxVUjB2w
X-Gm-Gg: AeBDieupXtjCBh9YokBp9UetpkWjriEBBCsIJMx/bDJfaJoHQGD2ZriXSHm5bWXq+hs
	DqIxCKB0Npv0Kk4R0ZGuxe8vs4yTynsxPQyomkcFZGy7BZNbFnOdA6fIPxJZa69cfk0YdY/rPvl
	urXj2VHxXelO47wxk9Ef3WHyz8O8g8GNHpwdti8n5fWVRRPguCjQ3dXoMXtCmpzD+LaD7Xmbyn5
	kVsrYK/RMUClIsByZ/DLX1BFJe94ULpQHASlxLoDsKU1EqpjHmdC8i/o9GeV0dRVOACb+EXWUXm
	mvjoxHgxw9GzA4wkl9MKUiImlfONrgiElad2TPOM1MGf4n90xjOhTQCxyv2W5CWLLerdI/KWlQ+
	mHSRGhjzWZ/f4M16xgZdkpxBiBiSTm0X6AEQ1rkXS
X-Received: by 2002:a05:622a:51:b0:50d:9e36:f95e with SMTP id d75a77b69052e-50d9e370192mr170670221cf.39.1775688695358;
        Wed, 08 Apr 2026 15:51:35 -0700 (PDT)
X-Received: by 2002:a05:622a:51:b0:50d:9e36:f95e with SMTP id d75a77b69052e-50d9e370192mr170669871cf.39.1775688694967;
        Wed, 08 Apr 2026 15:51:34 -0700 (PDT)
Received: from [192.168.129.206] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d521952c4sm164382331cf.4.2026.04.08.15.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 15:51:34 -0700 (PDT)
Message-ID: <97b81868-6410-4c79-a242-679a9f04f073@columbia.edu>
Date: Wed, 8 Apr 2026 18:51:33 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] block: add BIO_COMPLETE_IN_TASK for
 task-context completion
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
 <20260325-blk-dontcache-v4-1-c4b56db43f64@columbia.edu>
 <c4453f4e-c1a2-4f5a-b278-76b63d5dc4a3@kernel.dk>
 <01e6c582-fbab-40ec-97ac-02675e6a08ed@columbia.edu>
 <699933c1-c150-4e10-a5fc-6f128260d0c1@kernel.dk>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <699933c1-c150-4e10-a5fc-6f128260d0c1@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDIxMSBTYWx0ZWRfXxhLumV/9+mxe
 i4LzjKFoQ+Ec5wlGTrCf7ydSqK8IzMvbwlNCtZoGXqAnbxvk9xT9kq5OifWv7XKuiUc4eDPnbzn
 ORsWsC6ccbNrfuJSXWlXI+Y+VRxbO20qcZM7VLS58TFyoMJXTO1Bkgbv8nsyQrUvearnwRj0rRr
 UAmWv96ZkJ/zEw0Dd1j4anlHEcTa4ttKopErIr0XLfxUgozDY3ZbzDFX/9pBdphvaeB97FZtHcL
 Si+7eLvgnAHd0TN5vHVBIUTE0XnZbcFMcJ3Sn3qc0Oqurwr8WHiVVSwV5z7MudlnPfMDqGb5GL0
 /QkXsY9dG9kYfynkG6RpIQZplhqr9ncizD/URBBs8bADQPGiZXrCwOlRW52lsNiiw7zMmc53PQM
 IL8JrdjJeZB1VNNaVwqwIWKufinD8Ha3buJdNVduhwYJlO3Lmmpmevgnnxq59U0iIY4nDW6/fAb
 LUA5sRx25CFTMaxja7Q==
X-Proofpoint-GUID: AjmcRXzosM591_YshlmSMi-JfbzA7pGc
X-Proofpoint-ORIG-GUID: AjmcRXzosM591_YshlmSMi-JfbzA7pGc
X-Authority-Analysis: v=2.4 cv=N9AZ0W9B c=1 sm=1 tr=0 ts=69d6dbf7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=lI5dGhs4q9fbHD95aMQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=10 bulkscore=10 priorityscore=1501 clxscore=1015
 phishscore=0 impostorscore=10 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080211



On 4/8/26 3:51 PM, Jens Axboe wrote:
> On 4/8/26 12: 48 PM, Tal Zussman wrote: > On 3/25/26 4: 14 PM, Jens Axboe wrote: 
>> 
>> Thanks! I'm going to give Dave's llist suggestion a shot on top of
>> this as it seems like it'll simplify this nicely. Looks like that'll
>> involve turning bio::bi_next into a union with a struct llist_node.
> 
> Since these lists can get long, I'd keep an eye on llist reversal
> overhead there...
> 

Going to send v5 shortly -- tested with and without the llist reversal and
it didn't seem to make much of a difference. This was on a single-disk VM
though, so any stress testing you could do would be very helpful.

Thanks,
Tal
