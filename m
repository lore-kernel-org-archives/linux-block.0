Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE96A33A
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619196; cv=fail; b=PIplMTgwERJXZe+2j7zHFYjKfZTrCfzElP+2aou4LtepirbPrZUMqo4gQSNS/lmx9NoK3bDk/QGUmfXCf7hxTGYq0peztG2exin+h5EeOz47x81JeDA/KrW00BdevDo2KwfkZRdRulyt8R9Z94axjHu9xtOeFMFC6W7/sdCBI9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619196; c=relaxed/simple;
	bh=wCVYtABVrL1R6Zr9B2cVJ0wu/FsNuvIEmMy9FCM2c9M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ogf2ZAoa6omHarEZRFoS7RBZz33gZDYBfvxjOOkF/+tbaYkBv2KH5KTn20s0yG8WOzPCIlWCBBwIelGoJhJbSXtzI0aCzCZehq/BuKcqkxCInUC319WoBFlnC8kio9/M6Dvy1NbrKCk5NZ4MA248bsUWnf/ntVC4FjCRrzCtxMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CvKnawRe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CF6Idju/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CvKnawRe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CF6Idju/"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UCA8nS020821;
	Tue, 30 Jan 2024 12:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LDCDvfQVf+27PXXwCdhTO/epFnwxMAp5ntuHyFABvTU=;
 b=CvKnawRe19NC8yDPOkFW32SbHZ2trlV0i0LQ0T5mIQpXOAlvrXLcT7G9uevom17db7JA
 Bm7q0pGgequ0m9N6CB9ZAwyJ6kJY9uB7HMhHL39vvc6ElaTrttMIzrvvdvhryhQoDJZl
 EIDbpXvZILoXwpch/uMNu+lv7Bxo3XBmR/z7mv8wWJ4g6xQGxcFeFrgrboAEAR529omF
 RAf3Z8Ct5DrkptKnwrkIE8dkjwkAA0ZseHIfhyikQos9Ysy+Nr/Rhub47E/lVfVnwHLg
 5j1uGM0pVopX3We+BV6ZL4frq3bKjNHY/JpXKqncIk3QcThLHT9X5RF64bfdRHLAEJDC Kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuxmjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 12:52:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UBK1Y0014484;
	Tue, 30 Jan 2024 12:52:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr972vch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 12:52:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhwqmB/DG7FYwwisBO+dvlRNTvAKgaXcwiZVULRdDIXGrJBgjV/Pel71EuAkTHaha7bg6NrkcKWmlkLMGDeZp6w8T5CKYHQrK9PHiZ+HttiYK9ks2FaJ7NHVSQS4drSc0j4k0adnroTae+7mSNpqbybc452nNKukb95tK8GQqdbrE8jXyRw0R0DjPTnk/0z17bA3a+dO3L2t13TQlKLjpZ5gE/kRF+ov1T5D7mLwov/uEOMYRRoo1Um/qTo7qOOzq9gWJeov13NTadGeHAart15+z99zFbI+wPRIy0QYxJ1j9Jc2AhYOXS6bzh1zdF3nR7A5qDKgYYK0cfyo+yLuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDCDvfQVf+27PXXwCdhTO/epFnwxMAp5ntuHyFABvTU=;
 b=NQlswpZ+YnFl+SnY5sg5e64bPWh5lCwMJr4BHrN9RhyhCCKhoZjw9BJrJrSS85J/4JotOvQrtI1Vbt0ObcWhNTACG0lIbaBNEYmeZV5e9zR9jbv6olo4xSS85TCj3lUkt6G48PztEgqX+BeAhqSY9lYq6PCPCaPltDjmMkRP7pyCeR1PHDWTdDqE6ir4CMjlPv5i5LU2WfF7HdCCuX2bEhLghd8cV5TyBHazu8o8LPXrlSHeTpXlAm82DMKYoyI8xBwCg/DAj/orj9NJ1i0ZboA9BwuhpaT9TAacGCTM1NuhGbHlVpEjqbNHlKP5ONl8KinTN9wAmSdv7Mo5qOS8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDCDvfQVf+27PXXwCdhTO/epFnwxMAp5ntuHyFABvTU=;
 b=CF6Idju/psNkgwVeN/Sm+vBirqLoUdYdktbAcYRi22Lm5h/KfbeapBtTEaCvJvORlIBRvO5dpGMu2raFAn2PX3ClxFcljt+Ubzk1xzadJ3tZu/fSxMo8SSr8A396MZ+vDowQOrwKsTPkyT7sYHxYgz0rY6X1lt8g/QZmCxcvNFo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB6499.namprd10.prod.outlook.com (2603:10b6:806:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Tue, 30 Jan
 2024 12:52:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 12:52:52 +0000
Message-ID: <22fa7a5b-ed57-4743-a682-60df784e0dad@oracle.com>
Date: Tue, 30 Jan 2024 12:52:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] block: pass a queue_limits argument to
 blk_mq_alloc_disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
        Hannes Reinecke <hare@suse.de>
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-10-hch@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240128165813.3213508-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5ce6cf-f0e4-46f1-c37f-08dc21925ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iPKWAv26w4+uDpcRGA8yRAFeflKzCQyJ/E4+u7W04TMQO9EqdR9GljXLle/V2eRNZkGvGBSKvpwc5RGuRLd1WoNuCpDolbp8lIWV+Vg39npOMJ9zSJmfvHkZGpcaxasNy+7hO/7PeoBXxtLzoVUocA8gqPVg+RjwhkeQvdvng486dbNOatEIg9YNglx7nL3Lh7g/Q5UQ56qlb6ZdQtZFqKVofsyo+JrvOLm8kuvjBWbxqfPAY0R1/ldUtFSaUupyKoFoZcfmMIZQpYRmYc9Nlhhw5S9TjaPe8mxLXTJS2IimHbaRFELKu33+SBLYbininPFh9eBWvB1nBv0ISO4XtdLCeHb5O0gKXmw1AxU+vr0yE9BLCXiJiTzOCQqddiiAjnVU/WeT1eSca/BPrF9msj8C6eXj79n63uYnfJPJO/9RRkHN38BCGtaQCSfHBgUlnmVvpdM0bEtH6jjV10uTctXeegCIZgh1yERaxgDuDcM5/BM64H+9PeVXo2No8PjjedaNDs0Id9bPkalBepQ1b3cNkc08UupAWhOeFmmvi3tfZst8n2r9oKbZHhIp0Id3EeJvB2Gd1q8fLi5ortXNdMv3DHpACYTwjhGmdCQGysstqkmDBdKhUWfs3sbiaYm3smahCwRRj67XBwFUEgPtQg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(41300700001)(26005)(6512007)(2616005)(38100700002)(8936002)(5660300002)(4326008)(478600001)(8676002)(7416002)(6486002)(2906002)(4744005)(6506007)(36916002)(53546011)(6666004)(66556008)(66946007)(54906003)(66476007)(316002)(110136005)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlI3dHRhd1dxL3gzTXJrT1dweVJCOVlSOHVHbXg5bll3MDJFU0FTZ0QvOWZR?=
 =?utf-8?B?cVBkWmd5c0xrOHV3Um03VVQvNXp1czh2RmZ4WHNwbWVSbUtJV3pEVFVZZXZk?=
 =?utf-8?B?UzNFazBsMTBSelhXbDE5akJhYnNIZStYekpqZzZheHBzelhxY2N6dVRKeFdX?=
 =?utf-8?B?MlMvTXdSS1JjV1hpbDZaWGNIL0ZRSzBMRUQvaC94QlA2dEp4Z2Z1aVNvaitB?=
 =?utf-8?B?T0xaVDZrVitIbWxtVm1hekpKT3RwRnFVckFJYXdnRC9Mb21ubVNpNUEvbjIz?=
 =?utf-8?B?R0xPbDF6dlNkQVhscC9KdGttaklzL0xzSnNpbTdlSGFHd2ZYVlVsRlRqSTZU?=
 =?utf-8?B?cUtBVnNFT3JEUVdNTzhldDlVZnhTVGpaV01Cb2hEY24xUzR5eExHbXNyYmEy?=
 =?utf-8?B?WlpvYnZnMEtvMkNsSDNISWpCSUpLZGdqSGVnekhzbyttWFFrOHQ5ZVBHU0hj?=
 =?utf-8?B?b21mSHBTRE5nNEJtQlNBa0ZYRC9JWlRHTkpnS3F0WkdhelFIQ3dCUGNUNVdE?=
 =?utf-8?B?Ky90QWhIOUo1M2IxZDdPU0VqRTZpdmNDMnF0ZjVWNEJlSzV0QmVKSWJ4TDI2?=
 =?utf-8?B?Ukx3TGNHcXRFb3B4cmQ5d1AvSHNCVXVpa3dFdHd6aGdYYk9oZmJmMzNZNWJ5?=
 =?utf-8?B?RWhZYmVNZ2dnRUlpSEc1N1d5c1BaT2lhV2h4QkJaeEhYUEpNZEVqdW0yVDJw?=
 =?utf-8?B?UWZ6NWk0SG5lcmRkYWk4ZWg4T3NudStHcFMranQ1TXAxMUNCeXNYV3dDejRV?=
 =?utf-8?B?VjVEN1JsSkJ3T2RhcGNjRStMbmRwVGRONFkvTDkxVHpiMm1WR2pKR3VRWTNN?=
 =?utf-8?B?UGRxSVdoaG16ZXlUUGIxOCt1OEY0UHp4Ryt4Z2xlaHh1SE1YTytMc3Vwb0J2?=
 =?utf-8?B?MWJ3U25leEcvay8vd2hvMHFWb0xKUnBKaDR5bUNHa2dWRlRaeXRKNzA3Zmcr?=
 =?utf-8?B?MzllMGZnOFEwODdsMWhrL2p1dWhrMmFKeDJzRitJQnZiK3NqZXhGazFtVG1q?=
 =?utf-8?B?T0xDb2M2ZHE4UmtMUTRZZnMzcGNscEVnRzQ0NkRmVlpLYXFwbGdkNmdlQUt6?=
 =?utf-8?B?V0diMENYYTdBQ1I1Y2FVLzQ2a1l5ajBQenZKU2VQdC9tWmVZNWFVTndkaW9p?=
 =?utf-8?B?eFdqRHR6OWI4VGhhWm5ncVR3cFZtZzh5NlkxWGNoY0dCdy9HQjlyUjhCdGNv?=
 =?utf-8?B?NkR0aXZNSkF5Mk9TM2VpdXhvaGllWGFxaldVbGYxT1FWeVRMR1FvOHh5bDFn?=
 =?utf-8?B?N0d6YVZ3WlVzZEpuUUNiUHlES2hTVERsWHg2cXF6djVCbVVCRzNYdm5HdGpK?=
 =?utf-8?B?L25JSWRza0ZmWUlxdTF2RE8vKzkzYWtSZlhXN2hrK05UclJDUFV6UmRlTFd5?=
 =?utf-8?B?T2NsaGtmanB4ZVlMT2U1NmdHRFdhQjkwcDRWS3J4dVdOWlEwSGQrOVJUVXFp?=
 =?utf-8?B?NFJzcmtrcDcvL01BUUlKOXozbnNhNS80bS8wUFRXTXBzYWhkOFBHaSs3ZzFJ?=
 =?utf-8?B?N3VzZUZUZUtFZTZhTUZ4b0RRaTZRRXFLUG1CMnoySVJWNHUvRUgxUHV0ek1K?=
 =?utf-8?B?Qk1UNVNZenhhbU1DNlNuSmNJMGRCeE9RSVlqK3ZnTThIVkVKUVR3V0pnSEs4?=
 =?utf-8?B?aXlYZmZRUlBLREZmWVlpUE5xSXdibllHT0g5WVJ0Q2k0d3dpTlJISFNXQTZH?=
 =?utf-8?B?dDdvUWlTam5kL1ZvVUs3a1MxSEMwTnE1VzRKeDJGQ0xFV1Y2dUI3MVlyZkFQ?=
 =?utf-8?B?aWFWV0ovOXoyYmFFQ3lIOFc0ajVPS1dWQ203S0pUcGt0YVVrWkt2WkpqUmk1?=
 =?utf-8?B?UEpwRzg1VHlFMEhwbWREZ1IyaEo4QjlpRTc5RktGYW1laCtNbkpWcEVwT1FI?=
 =?utf-8?B?Z1ZkaUFYS004czJqUktnNktxWFJ3THRCTkdHTkw2bXZPcnhsYXBzdDJaOUgy?=
 =?utf-8?B?UWR3Z1B3VldzRERsMDRaWEVXNjZJaUg5VnB5dGhBL2V3Nk5mTHBoM2M1ZlJ2?=
 =?utf-8?B?V1NZV2lvR3I1QU55cGtXbWFhb2VkWGFRT0lnckJXZlZheFVacU1kK1BkQWtR?=
 =?utf-8?B?NUVxZE9mRzVhL2JuK3p5clJsRUM4NEYwWUkwZVNOUHVma29YNmRzRTJQTHlh?=
 =?utf-8?Q?XnWX3b0/R0sWF/5LaKQ/fPMiq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fmqOqlYO1LIfS/K7uPHvQkIidvvZEtXbPncNn2cHhiqUR7RDf7vJuV7NdJ2wQyzOqR35QVZ38zLU9jIYp+HEPXGZxW9ZtRJ6fuOqzoRql2+EDf34GFyULIi9yXBixdCwSrP6H/f5cwPAbj9I4YMxcWnzQHgc+ZKcnZ2yCbGAeo7N3pQ/J7UHt5Cj6kyAacRKLczd46FWrKscpelb+/ibbhiWWFOFma8gnELqyz7aY95FsHRdn3G1136vwYCyKc4ZCDLyrTZoTunLol/qwdGJlotHm6kZ0rZA2zmCfFpgG78sdaxVHA2efTvjtO7g2GVukH3tg57KwyEk9lTldkHVBu4GlIlgftrahgavx45ccSpbH7qx00OeACIgGet+yrDf3aytUe8dm9T7eEXPlEMBsgZ/0lHSRnN1AFcQtnF7b5D+CvK60TtCumdon9NvrFYH9jLn1J00Ong32DGFmiY87A8gfg+PCpnHKCl75OTVgejho/AcFKheGPmrs+/rFqg2N510lDBge2tF7+wbsGFTs5m3c7WJpaeurgiUA/cNZpBWXC3N1xF87xJZQ5g5F3CS8XvuH4OqRzI3LBVUk+1xLQkQ2L9ynl94Mh5X6Ra3DRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5ce6cf-f0e4-46f1-c37f-08dc21925ea2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:52:51.8513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdynYOC6cABiWa5vSDtdLMHo+qN60Rgieyi+HvKX8FwMNATOPC2nDJUWs/KImRHbnsBHdlP99gzkTax2tbOBHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6499
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300094
X-Proofpoint-ORIG-GUID: FZsvTU8xXRKsrL8gNdfBHfZqH-Ag18B7
X-Proofpoint-GUID: FZsvTU8xXRKsrL8gNdfBHfZqH-Ag18B7

On 28/01/2024 16:58, Christoph Hellwig wrote:
> Pass a queue_limits to blk_mq_alloc_disk and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Damien Le Moal<dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke<hare@suse.de>
> ---

FWIW,

Reviewed-by: John Garry <john.g.garry@oracle.com>

