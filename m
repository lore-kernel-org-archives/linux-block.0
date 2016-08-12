Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:33073 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbcHLU0u (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 12 Aug 2016 16:26:50 -0400
To: Tom Yan <tom.ty89@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Shaun Tancheff <shaun@tancheff.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [RFC] sd: dynamically adjust SD_MAX_WS16_BLOCKS as per the actual logical block size
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <b7f44789e0e68fa57d2e3cd059ac3a5bc6d53495.1470954520.git.tom.ty89@gmail.com>
	<yq1bn0yptqq.fsf@sermon.lab.mkp.net>
	<CAGnHSEk1UG1CaX+2zv20ONxnM7XavGvW9kX2KSPy7R7ZoKL_pA@mail.gmail.com>
Date: Fri, 12 Aug 2016 16:26:42 -0400
In-Reply-To: <CAGnHSEk1UG1CaX+2zv20ONxnM7XavGvW9kX2KSPy7R7ZoKL_pA@mail.gmail.com>
	(Tom Yan's message of "Fri, 12 Aug 2016 12:52:57 +0800")
Message-ID: <yq1shu9n37h.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Tom" == Tom Yan <tom.ty89@gmail.com> writes:

Tom,

Tom> I don't really follow. What would this BLK_MAX_BIO_SECTORS be? It
Tom> doesn't appear to me that a static value is going to address the
Tom> problem I am addressing in this patch.

0x7fffff, the maximum number of block layer sectors that can be
expressed in a single bio.

-- 
Martin K. Petersen	Oracle Linux Engineering
