Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1322EF5
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522578; cv=none; b=VPIXQhlRNnEA1TE8gkF5SmCe6ldPlnDreeuvO+/C5Qs5KTl+Rdm0ZY0EROJW4OYZl777tNHZDeLzYWFkduXkZnpLAbedfcVokGjqGHrX6ZrV75w8Nw/aBtKZfkGLi+6Rj9gQ+Yh/jXT033orfcbWFj6ZjZxrGm0T727b4XRXybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522578; c=relaxed/simple;
	bh=qoEOOX3YLp/QVdxBfVz9Fnwqv24cniUGOsZlBPUlqc8=;
	h=Received:DKIM-Signature:Received:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=g7gPJxLtedOscbwna9C1Bost29xqAZqBI0jqIEbJQ44suwVaOZ51ZcXCdoFOuHZeC7fainr11rZ21ohG181zlzIAnOKs1cU/uXR9Vj7/wy4shd6no37QoZTLvqnyz4bWMhhWFWMt+F8sn8ZrPDEGrOTiNptTX2X4pvfu0hyI6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=GPvJLwIl; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="GPvJLwIl"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HK0MVc007311
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 15:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version : from
 : date : message-id : subject : to : content-type; s=pps01;
 bh=mNgW9yXGmcFpv8TQ0N/YIz/pNkRXw64YC9gEZeE1Nyc=;
 b=GPvJLwIlfzpujEljpcZRnZ+za+wdGx+Jnfim9k2KcpfOtD4ttNnfayK0EgPquYsmjVZR
 3rIQZHihVmsU377yhnkFXJqP9a3pAvE2Lu2Ttb7GD3KWxm9PVVRp55XF8Uavs93SfXSH
 eCtsi0MQJShjpe8sMBGegAHBQmZp3lyPkPmwAebKzWOlM2QodM1SHJK/PB6ZSNJYwuOF
 5rJeER+PrSI+501zX81jEeVqmx6bj+ertc2B9z6pdYLXZDKJoBN1b3hwINSjFE4FUBAk
 6mpWrsec5GxQA3aB6OH7Fkjxb4So7Wg/qPGTVv1MZUToaj7v5RlO0DrQSzMP4q8zVFWv 2Q== 
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 3vkqf9tagf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 15:16:16 -0500
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bd6e446a50so4682275b6e.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 12:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705522575; x=1706127375;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNgW9yXGmcFpv8TQ0N/YIz/pNkRXw64YC9gEZeE1Nyc=;
        b=mhBW3Z97ZRTXUPmkiVTi7JxZ3wAVV63Zu1hk64MU5d696q+ypfoxUFrgjSoLcVD/fU
         mSjl0c967+sI3jtzz+bZwFXVTgDdpVqv8IFemtSYiEn13lGmnk4mfMBvZ2LFx0Qlf4o2
         izOfZfX5aIx4AbMycPTBoxe1u2FukIJDcxQHWYumMcEKSV+fiAbf3XNg4eK5cwdfHlPt
         Ka9kgxbvPTjBsK4U3EL9jnzQkOyMya4MU4jByzXseglWFDiARBbThorog2T4Q1+R8y4H
         87FYTafAF3BlGh34OMof80S/m3PHcFGtaitPsFd7eoZZMgnjEs/n0UsiPjWz3egSjrvY
         Kquw==
X-Gm-Message-State: AOJu0YwY//sZZ1cF60toNyYana0mRmAilbRd8ECittl3KD+ByaEKdwVU
	TAsSXaqcEzSdEokx+q7LBJmW41dLAxnINxgo6ehnZdlfNWYffWs5V7DB6sootWpeQHq0PjwatTt
	SOwaBOqyfK7hRsMQ4HsAbbIOjTnSP4iVsuAS9vfs3ma6+aoFy8oVzSg==
X-Received: by 2002:a05:6870:c085:b0:204:2d91:b155 with SMTP id c5-20020a056870c08500b002042d91b155mr12698494oad.80.1705522575189;
        Wed, 17 Jan 2024 12:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFrHGfspyqWm1fihNJD5MYpxRY8+4VDSQWOINlPV9CjOjiTd8oFqPABSGFzQSBoHrSfBoJ1khjhjfQ3CvSgiE=
X-Received: by 2002:a05:6870:c085:b0:204:2d91:b155 with SMTP id
 c5-20020a056870c08500b002042d91b155mr12698489oad.80.1705522574988; Wed, 17
 Jan 2024 12:16:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gabriel Ryan <gabe@cs.columbia.edu>
Date: Wed, 17 Jan 2024 15:16:09 -0500
Message-ID: <CALbthteVP3BnZuQuGWfW-SviB64CwjACP2v1N5ayDVFpnjEOtw@mail.gmail.com>
Subject: Race in block/blk-mq-sched.c blk_mq_sched_dispatch_requests
To: axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: Et_MMLisqqxTmz7EWQcSbSQfaz8I0U-w
X-Proofpoint-ORIG-GUID: Et_MMLisqqxTmz7EWQcSbSQfaz8I0U-w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=10
 suspectscore=0 adultscore=0 clxscore=1011 mlxscore=0 mlxlogscore=827
 priorityscore=1501 impostorscore=10 bulkscore=10 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170148

We found a race in the block message queue for kernel v5.18-rc5 using
a race testing tool we are developing. We are reporting this race
because it appears to be potentially harmful. The race occurs in

block/blk-mq-sched.c:333 blk_mq_sched_dispatch_requests

    hctx->run++;

where multiple threads can schedule dispatch requests and increment
the request counter htctx->run simultaneously. This appears to lead to
undefined behavior where multiple conflicting updates to the hctx->run
 value could result in it not matching the number of requests that
have been scheduled with calls to blk_mq_sched_dispatch_requests.

Best,
Gabe
