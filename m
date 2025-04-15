Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD317FBF6
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965885; cv=none; b=rNycP2TsVJ6Uf0GQPnNiRrCEc4oQq8a2xeO4QD7hAAfwXEi42QbXMRkONZkMk86iMo2iVItSvaEPX+A88USmVvgRl5YmhzgQ2d2tRiol8NJSc/e5llor5oeUt9oEPHyzZ9vfPiKWShHOldn1uNiND0YP03L/dzii7ch22rGKACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965885; c=relaxed/simple;
	bh=1P0q2UxODJLDtmK7k41p8B9HBb6A0DExZ4T2jb59vz0=;
	h=Content-Type:Subject:CC:To:From:MIME-Version:Message-ID:Date; b=NJEUw5Yicjdt3cxsiVxjAvQh2khk4HRQDKDgAQxtcNEj6NvAuH7Vmf73tZcRMtzDP13Bb6tz/uHhy5rS1jKz5gAaKpOrXaK//6RMIxGWQA2p/xkf5GZq269aW6jtPy0p33DHMnKGvkx4iKwVLwchL5QOriaq3oklYZq53IYqHQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=hihonor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hihonor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4Zf7ZH2pQVzYl69t;
	Fri, 18 Apr 2025 16:43:03 +0800 (CST)
Received: from w027.hihonor.com (10.68.20.79) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Apr
 2025 16:44:34 +0800
Received: from w026.hihonor.com (10.68.28.24) by w027.hihonor.com
 (10.68.20.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Apr
 2025 16:44:34 +0800
Received: from Pickup by w026.hihonor.com with Microsoft SMTP Server id
 15.2.1544.4; Fri, 18 Apr 2025 06:42:00 +0000
X-sender: <>
X-Receiver: <external@ext.cn.local>; X-ExtendedProps=BQAmAAIAAQUAIgAPADEAAABBdXRvUmVzcG9uc2VTdXBwcmVzczogMA0KVHJhbnNtaXRIaXN0b3J5OiBGYWxzZQ0KBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a005.hihonor.com
X-ExtendedProps: BQBjAAoANDyBeD9w3QgFADcAAgAABQBJAAIAAQUAYgAKAGQIAADpgAAABQAGAAIAAQUAFQAWAA8AAAAFABoAFwCsAAAA8lJ5WCnVPUSGq8gK57pHGUNOPU1pY3Jvc29mdEV4Y2hhbmdlMzI5ZTcxZWM4OGFlNDYxNWJiYzM2YWI2Y2U0MTEwOWUsQ049VHJhbnNwb3J0IFNldHRpbmdzLENOPWhvbm9ybWFpbCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1oaWhvbm9yLERDPWNvbQUAGAAPAJwAAABDTj1NaWNyb3NvZnRFeGNoYW5nZTMyOWU3MWVjODhhZTQ2MTViYmMzNmFiNmNlNDExMDllLENOPVRyYW5zcG9ydCBTZXR0aW5ncyxDTj1ob25vcm1haWwsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9aGlob25vcixEQz1jb20FABkABwABAAAADwBLAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLlNlbmRlci5SZWNpcGllbnRUeXBlRGV0YWlsc1ZhbHVlCQAAAAAAAAAAAAUAKQACAAEFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default W026
X-SourceIPAddress: 10.68.18.24
X-EndOfInjectedXHeaders: 16913
Content-Type: multipart/mixed;
	boundary="_2215cfb8-4705-4b9f-af14-b692645bea51_"
Subject: Re: [PATCH 07/15] block: move blk_unregister_queue() & device_del()
 after freeze wait
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>, Nilay Shroff
	<nilay@linux.ibm.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
From: Ming Lei <ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: <MicrosoftExchange329e71ec88ae4615bbc36ab6ce41109e@hihonor.com>
Message-ID: <4c75620b-707a-4cd8-acb1-879ddbc36331@journal.report.generator>
Date: Tue, 15 Apr 2025 02:27:07 +0000
X-MS-Journal-Report:
X-MS-Exchange-Parent-Message-Id: <Z_3D0PZWolXUdXnK@fedora>
Auto-Submitted: auto-generated
X-MS-Exchange-Generated-Message-Source: Journal Agent

--_2215cfb8-4705-4b9f-af14-b692645bea51_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Sender: ming.lei@redhat.com
Subject: Re: [PATCH 07/15] block: move blk_unregister_queue() & device_del() after freeze wait
Message-Id: <Z_3D0PZWolXUdXnK@fedora>
Recipient: yangpanfei@honor.com

--_2215cfb8-4705-4b9f-af14-b692645bea51_
Content-Type: message/rfc822

Received: from w012.hihonor.com (10.68.27.189) by a005.hihonor.com
 (10.68.18.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Apr
 2025 10:27:07 +0800
Received: from mta21.hihonor.com (172.31.16.11) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11 via Frontend
 Transport; Tue, 15 Apr 2025 10:27:07 +0800
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4Zc7L74x01zYnRwP
	for <yangpanfei@hihonor.com>; Tue, 15 Apr 2025 10:25:35 +0800 (CST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D94018971F9
	for <yangpanfei@hihonor.com>; Tue, 15 Apr 2025 02:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D5E207DF8;
	Tue, 15 Apr 2025 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dc5Y2G1t"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F25207A3A
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744684015; cv=none; b=brLCGJtT5Z+fyk2090ve6XPga1UQrgyXbjpPpdUMbA801RvFuFL7bRMKVkUp+jlgTjahz7uGISBuipMIW1Fnu9brfaGBMyJwL27ken06Zi/5gLNpqXYFzo6tC/p3eLoehvHtPFFN79h3TUHXNAoZYhAd7cSAogBfo4Z/homLn48=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744684015; c=relaxed/simple;
	bh=qZJQIOwX0WCaQmCFm1s6QWLRoOUoMui/y7xXS7JvbSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaZEY7l6qDkE3rAQlcVN3BZMPYyxPfRBMcVzdRCe6EbMGMiXDRR8CChQS4K97jigB5SozvUYPHjlEmMcvM2n3iyddeCKsp7yVW3xerHM24HKHsGtD5fAMpXb8InWwUYynUf6YC7PlXG0ggsD8y8RQpFZVedde2mxTWeEWE+mCnY=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dc5Y2G1t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744684009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ay/bC5wtlL5C89KNjsD+vS68Fh+RSS6ruxrIaqeVaD8=;
	b=dc5Y2G1tgTUgSctOqY0YAMRc6BJvnhTk/4LoxkwXvbBkrYGaby4RgRuSfs7EvRmCqVi/Se
	i6oaJ73tRuLgPgkr1/IAesAeAzoYvMwOICXNO8Uofu+vGylIUm++GJY2Nz5+A1iyUCcLuh
	3e0rvrJID43THSVb2aDVuNz3eAis9Qc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-i68JFbYkPcC89FW6wjE5wg-1; Mon,
 14 Apr 2025 22:26:37 -0400
X-MC-Unique: i68JFbYkPcC89FW6wjE5wg-1
X-Mimecast-MFC-AGG-ID: i68JFbYkPcC89FW6wjE5wg_1744683993
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CD96180034D;
	Tue, 15 Apr 2025 02:26:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51D3D3001D0F;
	Tue, 15 Apr 2025 02:26:28 +0000 (UTC)
Date: Tue, 15 Apr 2025 10:26:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>, Nilay Shroff
	<nilay@linux.ibm.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 07/15] block: move blk_unregister_queue() & device_del()
 after freeze wait
Message-ID: <Z_3D0PZWolXUdXnK@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-8-ming.lei@redhat.com>
 <20250414061910.GA6673@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250414061910.GA6673@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Return-Path: linux-block+bounces-19631-yangpanfei=hihonor.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 15 Apr 2025 02:27:07.3237
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: cc853519-11a2-4375-e48d-08dd7bc504a6
X-MS-Exchange-Organization-OriginalClientIPAddress: 172.31.16.11
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.68.27.189
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: w012.hihonor.com
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=w012.hihonor.com:TOTAL-FE=0.009|SMR=0.009(SMRPI=0.003(SMRPI-FrontendProxyAgent=0.003));2025-04-15T02:27:07.333Z
X-MS-Exchange-Forest-ArrivalHubServer: a005.hihonor.com
X-MS-Exchange-Organization-AuthSource: w012.hihonor.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7323
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=w012.hihonor.com:TOTAL-FE=0.013|SMR=0.009(SMRPI=0.003(SMRPI-FrontendProxyAgent=0.003))|SMS=0.004
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: f36d8287-40f1-4501-984e-f1384fa7e7af%%%41434762-a4aa-42ab-831d-d5158d6b2f34%%%9655f1bd-ca8a-43ce-87f5-bb82832276ea
X-MS-Exchange-Forest-RulesExecuted: a005
X-MS-Exchange-Organization-RulesExecuted: a005
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAc8DAAAPAAADH4sIAAAAAAAEAI1T0W7bNhSlY0m2lXgohn
 3ARR+GFDMM2U2c2BiKZVuBpZuRoQs27MmgpWtLtSJ6FBUjfdyX75BU
 0jx0QBOCpsh7zz3n8PLfwU1FS1WN6GqvaXI2omkyPSdpKLlcTOaLSX
 K1pO+SaZKM6KdcF7VR+5x+4bI8FFs6aGV4MYzfEFBu86ZFSZ6hzBev
 EwD9blEuLcqyqLb0GxfPkt+AwT3TutytmkrzFlVYr/5puOHTV/QtZX
 xfpLzKuMSn3OCQNpr5I9NBFmZEsspor3kvNXu4jdLUVMXmwdbiku+l
 wU59KEyaj12Ij7vNixoYD4SfD01taFNUPKK6qFLQQVnKZU1r5gpwWO
 acWVEmxyloVpXFVxsPBnqrLVdZUe9OX41orUz+pZI0Y0OWQPNQIJrT
 Tq0/cGpc8LrZbmrUdfWq8sGKsKF/5UXJdA02ZcGw0FhBRe0Y6mKbmz
 bHKMrUiO7UvfvC6TMDLVAqmxriirpuGAiVi9nLGu7WCvAI0LxpyjHR
 rdwxSSqV2sGMRcskVXd3haGzdDaTr6ez9blcX1yepVmWXUwzTi5ker
 6eTScJz3myTmY25aoxudKLz/TV93ma/1DWZpyxA/9ZolOIbKPSH7yn
 yZwms8VZsjib206b+g5tmdi/9zBDG3q5LlW6WzyKtZrcFRBLDcO0Ff
 rs2l4O42H8N8t8BEt3lTp4P8FNW8eH8fWGoNH6C3O3rG07bCVA3IW5
 4L1Ej9n8Q1GWlHO5t+ZrpYz32OHcgkgJc9vbOTBq2PBUgo9yBZRvyP
 bGPt9Hw9g/Bq8JWRutPjLeMpodBlSfWt9AMJAP1ZiunQBZluoA+rYx
 EGXwcFL0UqaR1TZe3T41uFZoso+rcqmaQYqzMb1rav8Wfr358d3q/d
 vlzZ9vh7EtbKhiD47OUTqzTjnhVrqsdvVoGC9dt9t/IY5EtyvCbkec
 YIjgSASBCI863X5H9AVGH+tQiFD0BiLuiX4o4i9PwX5XBKE4CVz8Ny
 KIxTEQoo6IRa8rolBEkQ2LENYTQ8x9McCIxNc+F7WwCFyk38GMAMch
 GFgyfSAf2/Tj/6viwXHaayUA6gRzRxzh05J3aKGrgjUURTYxcNz6mD
 F8TNAGdAGFRCC49BgBp2IUib5zadC1pQPH3yJg0e1gLaxLsKgzCIQI
 OqFz6UVkKfV8RRAAJVurFQXrIl8Fw5vvBwp5T9x+7ynGO4ZI75VXFD
 oTnnKxb8t98mrwpD1y1b3J3vlHvX1/6i8ofLw7dzRor8ZyDqPW4fAx
 8asIAf8B9IXLF+4GAAABCtEBPD94bWwgdmVyc2lvbj0iMS4wIiBlbm
 NvZGluZz0idXRmLTE2Ij8+DQo8RW1haWxTZXQ+DQogIDxWZXJzaW9u
 PjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8RW1haWxzPg0KICAgIDxFbW
 FpbCBTdGFydEluZGV4PSI2NjEiPg0KICAgICAgPEVtYWlsU3RyaW5n
 PmhjaEBsc3QuZGU8L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haWw+DQ
 ogIDwvRW1haWxzPg0KPC9FbWFpbFNldD4BDOcDPD94bWwgdmVyc2lv
 bj0iMS4wIiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8Q29udGFjdFNldD
 4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+DQogIDxDb250
 YWN0cz4NCiAgICA8Q29udGFjdCBTdGFydEluZGV4PSI2NDIiPg0KIC
 AgICAgPFBlcnNvbiBTdGFydEluZGV4PSI2NDIiPg0KICAgICAgICA8
 UGVyc29uU3RyaW5nPkNocmlzdG9waCBIZWxsd2lnPC9QZXJzb25TdH
 Jpbmc+DQogICAgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQog
 ICAgICAgIDxFbWFpbCBTdGFydEluZGV4PSI2NjEiPg0KICAgICAgIC
 AgIDxFbWFpbFN0cmluZz5oY2hAbHN0LmRlPC9FbWFpbFN0cmluZz4N
 CiAgICAgICAgPC9FbWFpbD4NCiAgICAgIDwvRW1haWxzPg0KICAgIC
 AgPENvbnRhY3RTdHJpbmc+Q2hyaXN0b3BoIEhlbGx3aWcgJmx0O2hj
 aEBsc3QuZGU8L0NvbnRhY3RTdHJpbmc+DQogICAgPC9Db250YWN0Pg
 0KICA8L0NvbnRhY3RzPg0KPC9Db250YWN0U2V0PgEOzwFSZXRyaWV2
 ZXJPcGVyYXRvciwxMCwxO1JldHJpZXZlck9wZXJhdG9yLDExLDE7UG
 9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDA7UG9zdERvY1BhcnNlck9w
 ZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZX
 JhdG9yLDEwLDE7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJh
 dG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZHVjZXIsMjAsMTM=
X-MS-Exchange-Forest-IndexAgent: 1 1901
X-MS-Exchange-Forest-EmailMessageHash: 8BDC87E9
X-MS-Exchange-Forest-Language: en

On Mon, Apr 14, 2025 at 08:19:10AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 09:30:19PM +0800, Ming Lei wrote:
> > Move blk_unregister_queue() & device_del() after freeze wait, and prepare
> > for unifying elevator switch.
> > 
> > This way is just fine, since bdev has been unhashed at the beginning of
> > del_gendisk(), both blk_unregister_queue() & device_del() are dealing
> > with kobject & debugfs thing only.
> 
> While I believe this is the right thing to do, moving the freeze wait
> caused issues in the past, so be careful.  Take a look at:
> 
> commit 4c66a326b5ab784cddd72de07ac5b6210e9e1b06
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Sep 19 16:40:49 2022 +0200
> 
>     Revert "block: freeze the queue earlier in del_gendisk"

Yeah, I know this story.

If it is triggered again with this patch, I will help to root cause.

The last thing we still can do is to just moving blk_unregister_queue()
after queue is frozen, or even elevator tear down. It is allowed to delete
children kobjects after their parent is removed. Just the KOBJ_REMOVE
event need to be ordered.


Thanks,
Ming



--_2215cfb8-4705-4b9f-af14-b692645bea51_--
