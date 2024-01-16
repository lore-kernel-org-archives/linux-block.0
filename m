Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3318C32
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T1WhdNZr"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240116104734epoutp04e4083e325d510454be1946afdd4ae310~qziICDLzB0304503045epoutp04K
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 10:47:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240116104734epoutp04e4083e325d510454be1946afdd4ae310~qziICDLzB0304503045epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705402054;
	bh=Bouy9Zbrzu+4299ES61BBENnvQictDHeWS7erE4RKPw=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=T1WhdNZrrfRPX5ZCAHXTQn8jbvesR3yJEaMe5i3PGOpSkMqxIzovT5u1QyYXC0kMs
	 hmyluqifTMYOaeeaKu3rHzAfhDrkYqdc0AQCeWeiE32x5gNzUqrdNIm317i7gS7uWO
	 Mp7+YLxoMEPOqvKjgmSJbo0Tx3BnWu2uuz1MeJmc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240116104733epcas5p46d905d33923e35b1cf7d4fc805fd55b3~qziHMTu6V2112321123epcas5p4T;
	Tue, 16 Jan 2024 10:47:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TDm1H49wRz4x9Px; Tue, 16 Jan
	2024 10:47:31 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.88.09672.3CE56A56; Tue, 16 Jan 2024 19:47:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240116104731epcas5p3c93afa0d7cae280f14b03a1a6c013021~qziE6wUad0439004390epcas5p3w;
	Tue, 16 Jan 2024 10:47:31 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240116104731epsmtrp129a38164db8f899b6eff1f1ef4c3b906~qziE6OvUh3063330633epsmtrp1Z;
	Tue, 16 Jan 2024 10:47:31 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-78-65a65ec32876
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DE.A7.07368.2CE56A56; Tue, 16 Jan 2024 19:47:30 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240116104730epsmtip2f7a61493d6c79834c7bc6913b02c5c87~qziEO_ZCN0935109351epsmtip2b;
	Tue, 16 Jan 2024 10:47:30 +0000 (GMT)
Message-ID: <df7f0c37-fdb3-8a7e-435a-80336fe74e32@samsung.com>
Date: Tue, 16 Jan 2024 16:17:29 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] block: cache current nsec time in struct blk_plug
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Jens Axboe
	<axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <6f98b078-5378-4d6b-8089-76bc53de2894@wdc.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmpu7huGWpBrtXy1isvtvPZvG36x6T
	xd5b2g7MHpfPlnp83iTn0X6gmymAOSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DS
	wlxJIS8xN9VWycUnQNctMwdojZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRA
	rzgxt7g0L10vL7XEytDAwMgUqDAhO2Ph923sBdvZKya1iDUw/mDtYuTkkBAwkbi55ziQzcUh
	JLCbUWLpkTdsIAkhgU+MEu+XO0MkvjFKLOn+zw7T8fz4LzaIxF5GiVUv2lkgnLeMEj/mzmMG
	qeIVsJNoXdYC1sEioCpx7HwXC0RcUOLkzCdgtqhAksSvq3MYQWxhAS+JBT0zwW5iFhCXuPVk
	PhPIUBGBSYwS2+bdA0pwcLAJaEpcmFwKUsMpYC2x8OZGZoh6eYntb+cwg9RLCJxil/h9fhYz
	SL2EgItEY6McxNXCEq+Ob4H6QEriZX8blJ0scWnmOSYIu0Ti8Z6DULa9ROupfrAxzEBr1+/S
	h1jFJ9H7+wkTxHReiY42IYhqRYl7k55CQ1Rc4uGMJVC2h0TvwefQ0J3JJHHi6znGCYzys5BC
	YhaSj2ch+WYWwuYFjCyrGCVTC4pz01OLTQuM81LL4VGcnJ+7iRGc7rS8dzA+evBB7xAjEwfj
	IUYJDmYlEV5/g2WpQrwpiZVVqUX58UWlOanFhxhNgVEykVlKNDkfmHDzSuINTSwNTMzMzEws
	jc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgqn5VqORWznw3++HCpYtMgxxWpOi0KD3S
	1bVWPn1hZ9dVX5WJx3c+mHp777+if4p1u8WawxkPfZiQELT9YdeeUOOWfQdEVC+ar7i3V04n
	fDL3219akzecvD3rz4SfZuf87LMzTuqu1vf41Mq4VE90q7vPe5djtx+GLy99HqHm9uPMKfti
	7xUmVlenL7Pzl2dOPniG++qsfAZHvvyDjdVLnk3LS7f/WTBjt8zkvJ8HeNgthe9JqFd/FVj8
	ZYvaAZs7+1oau14orWhcPbE3ICna8FlhwdOLN/68sT0qzenBeniOyoQs4+b+hMm/X8yZai5b
	X2lzXT2eU3O5hlz7snVL4+yc+ePYDh9xnKDCkb3GT4mlOCPRUIu5qDgRANeuahgABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvO6huGWpBgfPmFmsvtvPZvG36x6T
	xd5b2g7MHpfPlnp83iTn0X6gmymAOYrLJiU1J7MstUjfLoErY+H3bewF29krJrWINTD+YO1i
	5OSQEDCReH78FxuILSSwm1Hi5CtniLi4RPO1H+wQtrDEyn/PgWwuoJrXjBILdl5jBknwCthJ
	tC5rAStiEVCVOHa+iwUiLihxcuYTMFtUIEliz/1GJhBbWMBLYkHPTLDFzEALbj2ZzwQyVERg
	EqPEksMfoTbMZJI4c+IvkMPBwSagKXFhcilIA6eAtcTCmxuZIZrNJLq2djFC2PIS29/OYZ7A
	KDgLye5ZSHbMQtIyC0nLAkaWVYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwcGtpbGD
	8d78f3qHGJk4GA8xSnAwK4nw+hssSxXiTUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpi
	SWp2ampBahFMlomDU6qBSc/XhnXt3a3sBRe6vj27zTp937K/k5LvBe74xfeVb3Pd0qJ2976L
	u7OmhE3gaGWcI9MutmRx4tUCxlXf+dIcVMNXfqyrnpzl31VSz1z61nCzePrfohWbzh+87+iS
	ECP7TVtdTl85Z+uNigd86dfjhRwkm0Q+TJPfo9Jmy7DE7WTPLZVZ3v9Zqnzf+i3JXfWo4Zcf
	892tVUaurU++tIjncYgVn5k7Ydqe/YZW70SzxG36GpsT+12bikXXhDZfMsld5bpN7vs3jkdn
	wpZtf/xcvX3VW509+uJe78NlDizglGf/f7lSd/qqHbtX622ZutSswcrj5xWnfTszP/7c3Tb3
	xPMAQ40ejRobEcbaLZPPKbEUZyQaajEXFScCAEJQ6ArdAgAA
X-CMS-MailID: 20240116104731epcas5p3c93afa0d7cae280f14b03a1a6c013021
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240115215903epcas5p1518ca37cf0c83499dadba07bd3e51c77
References: <20240115215840.54432-1-axboe@kernel.dk>
	<CGME20240115215903epcas5p1518ca37cf0c83499dadba07bd3e51c77@epcas5p1.samsung.com>
	<20240115215840.54432-3-axboe@kernel.dk>
	<ff4a6649-9f09-23fc-ad33-06deb4845590@samsung.com>
	<6f98b078-5378-4d6b-8089-76bc53de2894@wdc.com>

On 1/16/2024 3:55 PM, Johannes Thumshirn wrote:
> On 16.01.24 10:52, Kanchan Joshi wrote:
>>> +	if (!plug)
>>> +		return ktime_get_ns();
>>> +	if (!(plug->cur_ktime & 1ULL)) {
>>> +		plug->cur_ktime = ktime_get_ns();
>>> +		plug->cur_ktime |= 1ULL;
>>> +	}
>>> +	return plug->cur_ktime;
>>
>> I did not understand the relevance of 1ULL here.
>> If ktime_get_ns() returns even value, it will turn that into an odd
>> value before caching. And that value will be returned for the subsequent
>> calls.
>> But how is that better compared to just caching whatever ktime_get_ns()
>> returned.
>>
>>
> 
> IIUC it's an indicator if plug->cur_ktime has been set or not.
> But I don't understand why we can't compare with 0?

Yes, that's what I meant by 'just caching whatever ktime_get_ns() returned'.
if (!plug->cur_ktime)
	plug->cur_ktime = ktime_get_ns();

An indicator should not alter the return (unless there is a reason).


