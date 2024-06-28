Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706C1BF32C
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584744; cv=fail; b=g/ii6PE/bmwitGbuWbNIxNcUQfBtXokjh75JLWQKLXDhePp9Nhp41K+SKAlVh/1pVufgkKguVH8ncICzRx9kL+sphViO3Sn/I8fHyrZVKbCIDRuIOfTzuFO3mOCSEI3MnNTJrCW0bKUMFKy0ygGnbTwPtpSh33QYZON4w2CgJms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584744; c=relaxed/simple;
	bh=D+LSbn5urUMvArCeIIZrWD7B2w+b0tVNiEWpMwV1+Yc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nqY5t6L+IpnwG32TGOt8+6+qWeM+ELlLCMhQ1p/G6nuWLnH0Us9zLLASDQCNqXpgn8dYy1jr6aDyeKfMQH9JO4GyEfA+tQhFP7DjhBdMR1cGqpheHqHLOI1XcMsrdHtm/PnEwIGiBwitJzDaAIwdoqCOgliGl1nh2g7U/vkXl1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kv79lUz7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I7U/+Lu/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kv79lUz7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I7U/+Lu/"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8MVW7009179;
	Fri, 28 Jun 2024 14:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=wdf2MBIJMMyPMnO5u54mDCMkQFFGcJv6SN+cHmlcNek=; b=
	Kv79lUz7v6k/2W3ncWfPNNqohScChcrvOBfUQcTwTbQH4uesD/HhV/h4LjP/nhgX
	W61GbuCMCTbH42NxWia1uaYOFGB+uk/3ZUjOUMnUEvmsq4epZ997XhellFZIdweQ
	XFSLzld/VukoEu2dJUnJm84/cqm9dxKNYHW4WAB4paqyXpKYJ/uvl7R9riEUTp3D
	6s8Ae/qaNOLSnDagHIZ0Ao42WpyKdqxslmSnlk3G7l8awn088LYjU1Ym1BG00VXw
	HpBvlOVXZNQAftbf3V7PbAa5gxpn7rEnYoE3kzBS5/Uwd6shl1D0g+pUJWgPX9es
	v26t+1QAN3a72y5bwJ4xPg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7srarn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 14:25:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45SE7qHj010773;
	Fri, 28 Jun 2024 14:25:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2jbq9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 14:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KylnvgGg9w3boovZppeYkquDXJ3yZo+NbUk6qgZiOry2cWAmRGEi13T4usmqhYa3UgZ1ru6W2WrgSF7hLbSK9dAauc48RCNKpWfxAmVQSYBdnpi6ii8GijsJUMj/X48/UQniqAYpd4LuirL2C7+1Vp19Qd/93EWAy1YqG2miJTfk/OgjlPzdUBLkeZJCJsSZSy5skAoMltuQWW+zpRhmT4oSe9DJYS6jeq2ESmpbpcDMjQ1ogPYb+LsIUvrHxrd5sIGZ11xgoL2dcYWLabDfzc/n/dpcylSvByi7iPa08ce1L4WegOxlENEQ2T7Bxh3xT79HeD4iBWuyUWoGaWMg0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdf2MBIJMMyPMnO5u54mDCMkQFFGcJv6SN+cHmlcNek=;
 b=d/K5QZWXUZ8szI8GxtabPu/htQ80csQljy/eZH7XTzbzAQdh7j5OPLKMtJoIcMjoFnFmROwzi4lQs/jBefvydBCW6f/7iovIG7zjNbf43kBw5SnCN8RpPZj2k/RUxKl152/nrpz+IO6H2wVLpPIq60ANoy7rOiFraTrl4pkTMGVTxtVmvqR/jS8ZwCfP8QyVOQSQFuBOl20GWKX1Rk4uGWNH2D5Mb7OYCCEMPRe92iAbpKggO2oQEfzx3un0X4w+FM9C63wZSAs21Jh4ZvAD5BQFqtzhNXgn9u77Rhr98KNnVSrqai++TpDZconUO5o908YMQV8MAJVJuc05rXIQhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdf2MBIJMMyPMnO5u54mDCMkQFFGcJv6SN+cHmlcNek=;
 b=I7U/+Lu/sfVYOwp/RiIyCaplj//f72arfTn84goEEaju2QWq9yykMKAbyRfhOOyTwirYr0nuH8T7DHy6SsZwmvjK0yE7IQkko9FLvMWo1XDggLQ0mPXszpDcpoikoMd+ANzPDsuzxbV4OgVqHHJ1beLeJ7icStdE9fOUiN5LoFo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB7289.namprd10.prod.outlook.com (2603:10b6:930:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 14:25:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 14:25:07 +0000
Message-ID: <4f515e0f-f370-4096-85a8-907942bb41fe@oracle.com>
Date: Fri, 28 Jun 2024 15:25:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] virtio_blk: pass queue_limits to blk_mq_alloc_disk
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
        Jens Axboe <axboe@kernel.dk>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-13-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240122173645.1686078-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a29e24-1e5a-4a37-8bcf-08dc977e1c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TWdOUUVYK1MwcVVqYnZ5cXBnTTMvV1EyT3BSczNUS1BCSTM5V2tCWDhmbnVP?=
 =?utf-8?B?Tm94RzdMMS9Ga2FjdllYVHl6a2lVM0hMeDlsNk1Ga3E5Qi83ZTNzSXBCRStT?=
 =?utf-8?B?Tzdyd1lKdTdENTlyeit2VDkwemxvVWZaODJDWXcxcFV1N1ZhRjVQSHI1c3lC?=
 =?utf-8?B?WVBUUWpSRzA4ZDRYTTlBLzNkWTRKWEQwcW0rUWN3bTN3RGhwZk11RjRkWjhZ?=
 =?utf-8?B?ZndWSVVHOFNxWG1BVWtuOHgwMzJTLzk4eGN3Y2VXY3AydGNIRVdkaU0xaEla?=
 =?utf-8?B?OU9uT0xKbjYxWUNiTnVlRHBDOEE5bUJDOStYalYrMEgzTXpWWmNLUW04SlVw?=
 =?utf-8?B?R25saytYK3VsenFPcncyTE9McEZhcjM2ODYyNlBWdWkyQkJKOXNrTWVWdVR1?=
 =?utf-8?B?b1BKZU1GaXVzc0V3NDdoQk9BdzU1TExjLzdpT2xRTTdWUlpJaHhvL2FOcC9Z?=
 =?utf-8?B?aEhjZU84RmdzWFJ5SGpxWkk1dXBKUFJaRUwzaWpwWjRzL29hL0JqOVlBaStB?=
 =?utf-8?B?MjFlUndlTGJlL0MwWEhBRkdHSldqL0NZTjJsU3V3WCtSdE1POFZUODc1ZmJE?=
 =?utf-8?B?cmpDQ1ZlWVVTbXFINEFoWGlVQXErSlQxT1E4K1VVQldoYWRFNy8wZE41MFQ0?=
 =?utf-8?B?T1QvcTZGM3RiR04wUUxqL29vdEMzZ1VNb0JxeEVXK2o2NVZwMzZabGV4Q0VM?=
 =?utf-8?B?djlxVkdmQTFaalFNbTJ3ZkZ2Y2VNc3lmYmJhV3Vmc2cvWmhSTzZ6emhTMDM2?=
 =?utf-8?B?OUhjMCtSQjVQM0ZvUnU0YlRWc2FtQWFKMXY0TC84TG4zL3BpSFNVL3ZXMGpT?=
 =?utf-8?B?QlVnQUthVFZVTURZSFFqaU5FTFBIQmRyREZxOUlkSGgwQzRBTDFpWFVlenNs?=
 =?utf-8?B?cUYyVzVPS0pxRk81bkFvL3hNaCtHK3hLS2JaZGxGcXd4WkgyNHRCR0M3ZnVt?=
 =?utf-8?B?alNiU0Z3dURjcGVoVmdEcm1EM1B4KzB1TUFoTGFhU25TcGJuOVptNVFkQVE4?=
 =?utf-8?B?UEozVmRYV1EzQ3g5ZmU5blNTTFNmNFZ2TkcyanU4K1hlbVFHZTVMNG9CMThL?=
 =?utf-8?B?N1lzNEdBU1lKT25UOGJraXVrZEVhTmMraVBmZG8ySFpzMlozcm5FckJjZHRz?=
 =?utf-8?B?QnFVWkRMbTZDdVI2TmVoNmdQUXRRbUlKN05jWGdqQnRRZ3orQnllRmd3SXY3?=
 =?utf-8?B?K1BleW5tQnAvUzRadWY2RTBFbU1OMDZ2QWtVZUNNU0R2RkVpVWd3SXBPaWdv?=
 =?utf-8?B?TVJqenFVeHNGNG5vbm1qU1phZ0lzVmtSS2NqNjlaUEFSTGlHaGt5MEFsVjF6?=
 =?utf-8?B?TlgvcHJJUXFya3cyTGlrRmgyTVoydnlDaEU0bG5WNm96ZDBKOGdpQlFXcGdv?=
 =?utf-8?B?Q0FzanAwUU5NcS9QWGdMcGNiUzR5eTkzeWk2Z1pTRklOYTBIQ0tscGV3NGNJ?=
 =?utf-8?B?akNpcFNGei83b3A0QTI4K3VBQXRrQ2dWeUtqalhxdFRHdk9rb0p4TlVKa0hC?=
 =?utf-8?B?aXR6U0ZldFhiUWdYSUVFdWsvVFBWUDdlTjFVRlBpTWlTbGNSZnhHZEo2Qk5z?=
 =?utf-8?B?K2s5NUJVajMxaG52cjcrenJrdUtFR2lPTEQ2anFvVDhDY1JWN3V5S1RQbmtt?=
 =?utf-8?B?emhCT2p1UC9LaEJkZ0JDYnQrWGNsQWR6ZHdveTM2dkxqYlBwOW1vTjdyRGJh?=
 =?utf-8?B?VFhEcHhhR0thcFVRQWhJb1Qvc0l6UG51c24rYkVRa0NnTk1QUEJkMXBxSGZJ?=
 =?utf-8?B?cGJXeno4enlBK3dCOGI5Qnp1VE9pL2ZKNkhjamZaLzgrbjBNN1I1eks4dDZQ?=
 =?utf-8?B?TVMvTUNRQm4xNFFoZmNZUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RlNIYlRBSGlobHdiL0E4VUNreEtpcjlEOFZTbmpGYlFrYzRFS0ZaazNicG8x?=
 =?utf-8?B?cHBKdjZMMmpuZDhFMER0emM5SDk1aFpReDlTaEJYTzBudWdZNkZjSHVBaXdS?=
 =?utf-8?B?RGtSWjlzSFVHWm94bHVHakVycjlkMWpkK2xCOVpLcFJTaTdWenJDL1JOTjZH?=
 =?utf-8?B?MkFCU1BKZTZuWVhNbXBkb3Y5dWsxVDQ4Y0hkZ1FGVGV6QVJrL29RRGlLZWNB?=
 =?utf-8?B?Y3hpaTNjTnZNUDZTTGJxMmthWWIwYWVoMFhyTHdoWGczbkljNW5DMm5GRVAz?=
 =?utf-8?B?N09PSlhJSENFRnRWT0lmOXFMN0xzZ3Npd093NXBLYks5eFBqazBQYmlSQSt4?=
 =?utf-8?B?M0pia2RjbVdkZDUwZFVoeGVsRWM0amNrc1I5UGFsQnFLaTA5WHRMcnVXWXhx?=
 =?utf-8?B?emtZNVJjbzNwbEUxak8ydjlmTExsb09KYS83TTBmN3dQZ1MraEVpOTcyOWZS?=
 =?utf-8?B?SEdLTXkvYjUwQkFTM0F4NVg0NXNSTGxOMTFxUGorMnRaVjlEZjJDbEU4bnpD?=
 =?utf-8?B?Y09SN3RXWkFYNVgxb1M3R1ZWOUtKaUxlemlCcW5BQmM4Sk9LQmZsRmQ2a01I?=
 =?utf-8?B?OWJMWmZ5TWpQWGpTSFZQU1BVZjRFdloyOUg3L28vMWRlbG5BejJzNnBzVGIz?=
 =?utf-8?B?SXBwUmJMN3BRaUdzMHZSaHlSM0tSa2ZNWDk5M3hqQ2ZWZEN3bWxLb3lVRlho?=
 =?utf-8?B?K2hFNHI1OHNuelFVWk1uWTdFdXhDaWwzUEVkVGVyOVcvUDJNN0toZzVEcFZW?=
 =?utf-8?B?WFJIa0MyQTNSN0xTaVBhU3ZaOUFvbi9YcTFTMVY3SWJKUXpBVnpVS0tuQkZP?=
 =?utf-8?B?MUVlLzRNVWtoNHFiNzQ1R3F5YUJ6YW9xRXhJUGdjb3MxMFBNcWpnT0ZjcU5x?=
 =?utf-8?B?ekFOaDNxOUdVbEF0K3NHUzBseDRycUxLd3gyQ3dYb2xXbDlIVFFOZEQ4Q3hO?=
 =?utf-8?B?MCtSK0Y1Rnh1TllVTnVJUFZXU1BrdXBwS3czbUpWbi9SbXRUMk1sdUdPRHh5?=
 =?utf-8?B?K0JndXFKbFJHSGRrSmQyWEdkbFdrckUveWNqWCtXVkdaTDBoU3dWN2xvODdl?=
 =?utf-8?B?dG10Q2drRDdISWx0YkVKbEdaMWYvWkl1aFUwUkRMaTh6dVVsWTZWYnlkNERl?=
 =?utf-8?B?WENuVTEvVGJ3RGowR3NHQ25sOW9xTGl2bUw4Q2hTd2hiMkM1cnljbXdDRkRh?=
 =?utf-8?B?S3hUeHR4Zm93YklZWTB2ZWpuU3BZMkVHL3Z3OFJzNThWOEM3cVgrdHRaNnVF?=
 =?utf-8?B?TWptL1d3RkxMZ1hBdFBvUHBTT2ZMZ1kvWVZRL2N6S3BPa2d2V0IxMHduV0Qy?=
 =?utf-8?B?VGNDV1FGL0Q3cFJIRHQweE42QnpzVHUxWm5EZzlJZmZsZk8xbFZpS0diay8w?=
 =?utf-8?B?WDJqOWNwWnJpeDlRTjhtZjBKUTMvTmhoOWVMaElMU012TWZZM3pqRnBKUlZ0?=
 =?utf-8?B?Skhza01GVGJ3cnNTTFJEQ2cxYk8vVi9lMGFhZ2RXS0NsN1U5N2d6OGYyWmN1?=
 =?utf-8?B?QXpGcExFakRBcHM1endDTU5zUk1TWGxmMGJhSWl3K1ZtMnlDdC9MYXYrYVZW?=
 =?utf-8?B?SHFkdGNycENoWWg4T09Lak9ka0ozV0t2RjZRNWdPUHNKekR5bnY5L0EvUmow?=
 =?utf-8?B?c1VaQjFqVEROZFhaRU1oQWdUREJmaG5UNUtkL3NvS2M3d0NyOUlNN3NHKytQ?=
 =?utf-8?B?MEFQdmtxV1B4UzJ2Z29kdEVXbWNHQjd5aXN6dkhlTjVoSUw4bXJaYzZjM3R5?=
 =?utf-8?B?SkdIcUpxQUQwU25VU2hjMERyRTYrSlpWQnNZRlkwUjhESlFNK3RCOUxTbnB3?=
 =?utf-8?B?clp0UkJPQVlEVldtRjhDMnc1RDQwN2tZME9Hb0MzYXJyVVFGODVpT3Z5Q0V2?=
 =?utf-8?B?TWNmb1c3a04yQnR0UE5IVFZRZENlTU45SHJBUHBNckNqT0RWYXBCY0pWdVNP?=
 =?utf-8?B?ZEV1emRBeWNqZFc4VG5RdGtDZ1RER0NIM2xCTjFNeUFqSE9XMk93N2RPcUFv?=
 =?utf-8?B?cVNtOW1JYlRiVnRsZlRZUUJ2UWhVcXZxQXZiQXQ1cUZBTldWdm9aT3RFNzRi?=
 =?utf-8?B?bFFRRlRLYlRWTTZtNXhuSlVQT0xURThSZEFPZElYTGt2bG40Y0FPTDlyMWZl?=
 =?utf-8?B?VFZOdFBESUNZcUNuVnZaQkp6b3h5NGZPMTZBQjUxU2dBeGgrbkQvdjZIUzBa?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4P1QvgGfncLgLEHPOjQBNKd0CZN21/QM2kxaTz4feP6EQ7fofKul99ZhB4ID6or7vcQ/T414awmD87Cg3luN/z+h/0wSb2+j4qBa+Hl48cWhDm1QLdycbwQy29V4r/hqS62LoKqQfqGphnLQ7hnCbzcddX2PutNoIH04PTzcDRoeP17b7DADU5LjJyyjASIFYfozUYBgfm3WjC755CmCz0m6sRG6a0ahbS1VujKTX9BZUDiNGYAxt0E7ud7ZHjztzXDtH8SX/aebOd9osYMjzJs5R3qJzhE1pChpgIp2xvo9td9sbOXHadhrWOheUzHvSxKOwy7tfKtdFtW9JgLXGA7AO8S4+AYZry+MXD59HT6qUnecSz9TdO1D1xv7P5hokfTMvRGPsmto5f31V35iONI7KcTbYTs25tGgq0YAiRWxngidSMwhf0tD0p87v7pwFXYMbJ62epxpzHlc2fmUIcMDZeLDzFV//iL1BvJa2DdkVXm0X8MrhiDiVEptKz8cYetuVUshuI/Fezk3Lt2M/IxvEtd/qO+qH0OhpzbQK3iu5d2CnV6EvOL/tRss1Zzx5Ynx7Kdfj77l2vH8H79EmxSLDIxIDcsHgjIH2TeVtfQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a29e24-1e5a-4a37-8bcf-08dc977e1c55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:25:07.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9sf5hL1AJuRNM4xEUB4XXf6C2QBPt90RBpXyVhaLX5zRxL28mp8TJ7oQdvR+7eTB9dztcrY1C2UyQrgy55CkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406280107
X-Proofpoint-GUID: oEmnrkk2RJ7XwjL5J-XijfesxQRwlI3n
X-Proofpoint-ORIG-GUID: oEmnrkk2RJ7XwjL5J-XijfesxQRwlI3n

On 22/01/2024 17:36, Christoph Hellwig wrote:>   	max_dma_size = 
virtio_max_dma_size(vdev);
>   	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
> @@ -1288,7 +1283,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk)
>   	if (!err)
>   		max_size = min(max_size, v);
>   
> -	blk_queue_max_segment_size(q, max_size);
> +	lim->max_segment_size = max_size;
>   
>   	/* Host can optionally specify the block size of the device */
>   	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> @@ -1303,35 +1298,34 @@ static int virtblk_read_limits(struct virtio_blk *vblk)
>   			return err;
>   		}
>   
> -		blk_queue_logical_block_size(q, blk_size);
> +		lim->logical_block_size = blk_size;
>   	} else
> -		blk_size = queue_logical_block_size(q);
> +		blk_size = lim->logical_block_size;
>   
>   	/* Use topology information if available */
>   	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
>   				   struct virtio_blk_config, physical_block_exp,
>   				   &physical_block_exp);
>   	if (!err && physical_block_exp)
> -		blk_queue_physical_block_size(q,
> -				blk_size * (1 << physical_block_exp));
> +		lim->physical_block_size = blk_size * (1 << physical_block_exp);
>   
>   	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
>   				   struct virtio_blk_config, alignment_offset,
>   				   &alignment_offset);

I think that we might need a change like the following change after this:

----8<----
[PATCH] virtio_blk: Fix default logical block size

If we fail to read a logical block size in virtblk_read_limits() ->
virtio_cread_feature(), then we default to what is in
lim->logical_block_size, but that would be 0.

We can deal with lim->logical_block_size = 0 later in the
blk_mq_alloc_disk(), but the subsequent code in virtblk_read_limits() 
cannot, so give a default of SECTOR_SIZE.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6c64a67ab9c9..d60d805523d2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1453,6 +1453,7 @@ static int virtblk_probe(struct virtio_device *vdev)
  	struct virtio_blk *vblk;
  	struct queue_limits lim = {
  		.features		= BLK_FEAT_ROTATIONAL,
+		.logical_block_size	= SECTOR_SIZE,
  	};
  	int err, index;
  	unsigned int queue_depth;

---->8----

Look ok?

