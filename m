Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46578 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588AbcFBRCg (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2016 13:02:36 -0400
To: Shaohua Li <shli@fb.com>
Cc: Sitsofe Wheeler <sitsofe@gmail.com>, <axboe@fb.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<snitzer@redhat.com>, <martin.petersen@oracle.com>,
	<Kernel-team@fb.com>
Subject: Re: [PATCH] block: correctly fallback for zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20160527054918.GA9521@sucs.org> <20160528092755.GB938@sucs.org>
	<20160602165813.GA18527@shli-mbp.local>
Date: Thu, 02 Jun 2016 13:02:07 -0400
In-Reply-To: <20160602165813.GA18527@shli-mbp.local> (Shaohua Li's message of
	"Thu, 2 Jun 2016 09:58:13 -0700")
Message-ID: <yq137ovttgw.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Shaohua" == Shaohua Li <shli@fb.com> writes:

Shaohua> any chance you could merge this one? I'll fix the MD part later
Shaohua> and make sure write_same_max_bytes sets to 0 after IO failure.

I'd like to look it over first. I've been away for a few days. Will get
to it today.

-- 
Martin K. Petersen	Oracle Linux Engineering
