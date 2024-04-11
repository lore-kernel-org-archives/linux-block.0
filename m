Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AE31B946
	for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 04:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896989; cv=none; b=B5/TcV1ZdXEXgs0HjtOqp7JUS+J/gmmWWtU4HNOqfRs6G/sKp8pTNDL1iOhMpTmPVp+XxKvJqgZSsgdlCYjHTAMAm8CKbejTrPcvod1mackuxqgVZANv12BDS1beru8GzCLN7NUdARlFmHNyR2H7OAaIVJCVT7VfSUv3gqdNSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896989; c=relaxed/simple;
	bh=ThOQ1iA0SZzxppMkdCwv7zhioP243OLB+CAxMQ/W/44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Cs/eKPVaU9N4fWyZ2Yop1EJvzxjxXYwe+E2BF0elFEebF9TvJBrI+aeSh+KSVE9vQ5MiwiKLcPg17Z4jcsI7gUdZ6ORfQ1BnNGnKiSivjzP3U/ZqLWjmnbg7aOgzpzsIFSDZWHKWpZjai20JSVEWLJeVTKjrC/W9RAki0uV+sxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=riX4f00v; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="riX4f00v"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240412044258epoutp025710e254251315f770825543e7e5192f~FbroYCb1v1782817828epoutp02i
	for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 04:42:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240412044258epoutp025710e254251315f770825543e7e5192f~FbroYCb1v1782817828epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712896978;
	bh=ThOQ1iA0SZzxppMkdCwv7zhioP243OLB+CAxMQ/W/44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=riX4f00v/FfXbwBZzT6mX92MTJGSoxlFd2dxBResKEUSwaCSr/CUZ7tquan4i9T93
	 IGrLtstkIDEsEldq/bsPfeZSGTtzo2UNpd0L9WMRjqkn/BiR5CbJYPmcap4QPyQ8vZ
	 K5+Zen4Nw4n8xle7r9tS9TMDKeMiqcJYoOiFzLJY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240412044258epcas5p28a9f08e50f2e510994cd50147b07934c~FbroK5axT1071710717epcas5p27;
	Fri, 12 Apr 2024 04:42:58 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VG3pS5LNDz4x9QK; Fri, 12 Apr
	2024 04:42:56 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CD.CE.08600.0DBB8166; Fri, 12 Apr 2024 13:42:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240411124446epcas5p3cac3d5d19a67f7711ea9cb2b751b8cf1~FOnAhsgxG1241312413epcas5p3-;
	Thu, 11 Apr 2024 12:44:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240411124446epsmtrp2503d735838bfa4187b6abe4c9c4d0d7f~FOnAhIPyK0446304463epsmtrp2I;
	Thu, 11 Apr 2024 12:44:46 +0000 (GMT)
X-AuditID: b6c32a44-921fa70000002198-72-6618bbd03961
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F7.CA.08924.E3BD7166; Thu, 11 Apr 2024 21:44:46 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240411124445epsmtip288d0d5f6b5ad90aedbbe3869cb0e92f0~FOm-pNNbt2124921249epsmtip2w;
	Thu, 11 Apr 2024 12:44:45 +0000 (GMT)
Date: Thu, 11 Apr 2024 18:07:50 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] null_blk: Have all null_handle_xxx() return a
 blk_status_t
Message-ID: <20240411123750.gwzouryerxwmqrjt@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240411085502.728558-2-dlemoal@kernel.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmuu6F3RJpBqt2almsvtvPZvFgv73F
	3lvaDswel8+Wemxa1cnm8XmTXABzVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWF
	uZJCXmJuqq2Si0+ArltmDtAWJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFe
	cWJucWleul5eaomVoYGBkSlQYUJ2xrPmLraCE6wVb36/Z2lg/MbSxcjJISFgInFy8lMgm4tD
	SGA3o8Src61MEM4nRomJOyZAOd8YJeb2bGWEaek/9YARIrGXUeLo3Ktgs4QEnjFKbJpnDmKz
	CKhK/GpYyd7FyMHBJqAtcfo/B0hYREBdYurkPWBzmAVsJX4fOQrWKiwQKnFw2R1GkHJeATOJ
	7UfLQMK8AoISJ2c+ASvhFLCU+NW8hwnEFhWQkZix9CszyAkSAqfYJTq3LWSHuM1FovvHVCYI
	W1ji1fEtUHEpic/v9rJB2OUSK6esYINobmGUmHV9FtRj9hKtp/qZIY7LkPh9fCIrRFxWYuqp
	dUwQcT6J3t9PoBbwSuyYB2MrS6xZvwBqgaTEte+NULaHxJkpj9nh4Xvh3BnWCYzys5B8NwvJ
	PgjbSqLzQxOQzQFkS0ss/8cBYWpKrN+lv4CRdRWjZGpBcW56arJpgWFeajk8wpPzczcxghOh
	lssOxhvz/+kdYmTiYDzEKMHBrCTCK60lmibEm5JYWZValB9fVJqTWnyI0RQYVxOZpUST84Gp
	OK8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6pBqbgzxsN3H11zyZ4
	fC/k/VH8TfLgtIyND+qefD4V/FZmH0tfyEP2+dK3V+pO0o7YmMdYoPImce0bFv9HPYFFb7iD
	y/gtDHwa7+VtjpcJrZlVfsDX6LVk6eZQSeff3WJVJSfZAvZOf1IeOpvx72aDWw4rtVjv3H+q
	rNMakPp1e3cDT//KG7bCHZE8fHkNsUyl1wzzZm69ZFt0rSLA+HmxkMEDU9Xc1o0in31t9rjo
	+S/RMOnmjROboXVe6feXNS+PtxX+mp4+VSL9q8w912WR3wUP71rPrcazTNL/t4/Lz601i1rO
	5Zbc1vyWLTXpAHe208YHhTum5YbaNk9RP2Kz5OrJy21RsXMYry3Y/C5KWImlOCPRUIu5qDgR
	AIVAn54NBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSvK7dbfE0g9+rJS1W3+1ns3iw395i
	7y1tB2aPy2dLPTat6mTz+LxJLoA5issmJTUnsyy1SN8ugSujY38Le8Evpoq2eTdZGxgPMXUx
	cnJICJhI9J96wNjFyMUhJLCbUeL8yUfMEAlJiWV/j0DZwhIr/z1nhyh6wijxa/didpAEi4Cq
	xK+GlUA2BwebgLbE6f8cIGERAXWJqZP3MILYzAK2Er+PHGUBsYUFQiUOLrvDCFLOK2Amsf1o
	GUhYSCBd4nV7JyuIzSsgKHFy5hMWiFYziXmbHzKDlDMLSEss/wc2nVPAUuJX8x6w80UFZCRm
	LP3KPIFRcBaS7llIumchdC9gZF7FKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcvFqa
	Oxi3r/qgd4iRiYPxEKMEB7OSCK+0lmiaEG9KYmVValF+fFFpTmrxIUZpDhYlcV7xF70pQC8k
	lqRmp6YWpBbBZJk4OKUamPhnyOSHulYd2xBfFHL2jGSnyIl3Z32kesN/6gXobmg7mWCzSlD9
	8fULV2RzcybnX3vl6yCRVfXnRUflP4OaBv8Y9ftnX3iwF1T3qQe+fG3n8nWGuZLX3j7rpQr9
	n4o1whY80ks89/H0XB+H7ZWf09+cesndGsXVKHzx4bons3mmCIQx9087lpV43j3lcWRt/7+T
	yn0F0V0aWyf8EU755lnYti/gqfpOhrDrt6RKD37Jrz57RXXhjcYfHk0vHuxmX58XMeWA49wf
	2xbPDF5jM2v9cpFjqZFs7pXvZO9or+Xw50hw1FnHw8mpolGcud5zVtSsVKlrN9ZvjTRcEc51
	NlYoNCBKI3nKGyF/1X9WSizFGYmGWsxFxYkASZzXh80CAAA=
X-CMS-MailID: 20240411124446epcas5p3cac3d5d19a67f7711ea9cb2b751b8cf1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_76cb3_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240411124446epcas5p3cac3d5d19a67f7711ea9cb2b751b8cf1
References: <20240411085502.728558-1-dlemoal@kernel.org>
	<20240411085502.728558-2-dlemoal@kernel.org>
	<CGME20240411124446epcas5p3cac3d5d19a67f7711ea9cb2b751b8cf1@epcas5p3.samsung.com>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_76cb3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 11/04/24 05:55PM, Damien Le Moal wrote:
>Modify the null_handle_flush() and null_handle_rq() functions to return
>a blk_status_t instead of an errno to simplify the call sites of these
>functions and to be consistant with other null_handle_xxx() functions.
>
>Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>---
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_76cb3_
Content-Type: text/plain; charset="utf-8"


------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_76cb3_--
