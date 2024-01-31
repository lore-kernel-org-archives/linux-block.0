Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C939FD3
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743641; cv=fail; b=SajjTT9otWEjysNNJhjwJW7ARqoX+jP3Gqgb5rVLJeFRHUZVVVjR5c5HoERQYKfioBoa57zyoRBnbCXDzhjPit4p9zu+nRVWhJWq2IAhbve65WCkKeHxDp18E4eRa29EdRcS/IB1Uu/nnv9aN9cZrBd1NTOBskKveC8nPi0Or1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743641; c=relaxed/simple;
	bh=9h6KeVK5u4iVaAU6pGzQp5YSjCL9YTN05uHFp0VvTAc=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=bCBQWOotCN4UXjUPato7xGCKVw14J3vxBeTwmpN8vtRww83f9OxJ9BnIBw8tONM+Ngr/7qKaJ4CInQ2iz2BN+Qnx5UeaNdpScJZWve9Uu0VaXoK0LepjToT1GT4BfFLHsMUddLGb2ZSLvUl4GP5ETQn7Dgo1yCcrK8gY2YoV594=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jrgBNJ5m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zceKxFxG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jrgBNJ5m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zceKxFxG"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VMUanf000468;
	Wed, 31 Jan 2024 23:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1lUxqeqA45RcwavLHu/C1yg6qqw5Vv+QIPTZC6dgGdA=;
 b=jrgBNJ5mHJm2giV1q13Sooh0MxMb4ZJbUHbucVzEjvhxQ/aVxBmX1NKbQ5FLr9s00OLK
 aab4p6z3Ta1kHy7v2rgPIU78sc4JDT5G5J9tHvZhpti7NjbDZzJYVldKbQ6Eu99t02H6
 f40qjsa4oYEC0WkORk6k4YMOeF8IfoZqTa13NTxlmIRy1nXFVzhNKAohjPwjqi7cDcoz
 lzjRnvRiUgRuHCYA/UYZtbNSjBNMa+18ELRAEPGJ5QSzf6Lh47Tzozl634LpLgpkOu8/
 v/e2G+dm7WPKUChTsang7N0WyWgHPWdMFt6OAxbd7stIRB5tJVjQ+isuEblN/xeBxKZR Tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2kdj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 23:26:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VLZZt4025911;
	Wed, 31 Jan 2024 23:26:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr99uk5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 23:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaMGHv9k5pksNfgvIdNDsnK9Dnqbk37oQXWFZQpQtB/3gFwBnyhgjtxglxry0zNM/TpTy3uYvL+S4ZK7+1TKwH2KUXJNKZE+GUIQMxVRMH3uYNGeWoeGCRHIwPy5IR2Om9VWnzwNw5yPKIXlzNEFFhRetuvlv0wPCRqQ4f0sp5ooAuqtgMzmVfZWnxHALyjU09mmLQDVkkT084bjMC5e8tvyEh9/PfW7lvC9stLKrBmFJbx4UFRvH8fyc5gv1b7QHX2Lwc0IcXpcHqbnOB8sa8hh79OewyYMKguU7Z3qhApE+Hf/NXoYw+zNX+xNvOBuBJFdSd9iYChO7In2GWRLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lUxqeqA45RcwavLHu/C1yg6qqw5Vv+QIPTZC6dgGdA=;
 b=GixTekXYgNFu/HZnVnX57vCVIM5q/3mWRHTz2P9tqhAlkTvBRpZ1P+UWoUk8D3b7Lyq5f2hOLF1V+k7I6k5sOcMYuQ8J0eYHMTL0oPPSRSMVjXl5m0XshjKSTwz9MOghDZ/+TfKhyjWHP9DsVF/KDX7k9WcTwDSJvnY6K56Svmx/cKujgy3lKjUCWagwNifQfACwcspdCY1secgxiMSB0//FDO1/wEzxHZwkSAtEMqG/FspvMD22LNRHUD8FsH6Xu0H2UTJe/e9fLYNgKG2zHysjCbeHk5c0fCGyvYxps58NdwA2OxgIqKs7EERXdvYePF96yvdFgnvRmfYtTjT1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lUxqeqA45RcwavLHu/C1yg6qqw5Vv+QIPTZC6dgGdA=;
 b=zceKxFxGkmzwIyliQyZkNoJ6GDvxQNA8TQLSs3VXNPksetllRWQzs7at6ZzcmfeLgrhESdaJNneC1pedl0BIC0Ui0hC9YStOJvtsI1fC9h6l1Fl21VWTsRcQElmwb1p5DQ2WjBweRe5d85bHf++hCt6bylIwswpoiokq2w7vsN4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ2PR10MB6963.namprd10.prod.outlook.com (2603:10b6:a03:4cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 23:26:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:26:51 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: atomic queue limits updates v3
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7d1qeax.fsf@ca-mkp.ca.oracle.com>
References: <20240131130400.625836-1-hch@lst.de>
Date: Wed, 31 Jan 2024 18:26:49 -0500
In-Reply-To: <20240131130400.625836-1-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 31 Jan 2024 14:03:46 +0100")
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:510:5::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ2PR10MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd43266-0c0b-4e4e-c897-08dc22b41aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	h8W4gaICHynLWJSfrF3NKuUO0kb+ZyyyhTnDYZJ15W4z4XZUU8u71JarpPQ89PpeTYvrmMOzxzR3RXj6Eof9RaStx9SPJ2qS96/IATM1fC4CSM1PvUrD9YlNkRBJHxpiqH0OCA17qdcmO6lo2OaVUl/yZl+AsEY6CpIHaiRdRf6u7HmIC9g2RSqEsTrNj4wKY8TWWhP/iHsHXx2YHEu3ZbR4w03jEvxlvphChwlb7xoyjHiqUkR9oJ1bKD+5kYv8CSPTOBy/4Gtl/2XvxBtaV0rTxjPnTAq7hG1iX6oMDt5JymMJ21u83y83DqKDWuhqe3hxoi1Q03bDQ0M49NO8T6QdKKnaLom2CobleEPO0TIbgOCWsaau1HzpqguvrhTyJGnLoQZwS0A+EUzkk0z2+5EaFHkTEjrX7+VIDoPK4bcQQgsmZGf/7givqPX/uXADLp3+6hpE2YADd12JBLBDXsP1UqvL/lQUs74MNUJlxBjzDwD4N7IFDnpvj5AJjmFMqjzzmTulaZ0ragumPo9dHGmDR3Of5pMT6/86JN9c72ydH9/3FOfawmIbr66Nc7At
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(83380400001)(86362001)(6506007)(6512007)(26005)(38100700002)(66946007)(6486002)(2906002)(36916002)(6916009)(316002)(66556008)(4744005)(8676002)(5660300002)(7416002)(15650500001)(54906003)(8936002)(4326008)(478600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?O+Hr+lsBKL9p5gW9kkKquhCfIpaAKpMqqm/FcGnprjQ3CMHlPmeavw3FV717?=
 =?us-ascii?Q?+wI/WZ5tuTtEkYdASvBPVc4/MycyDzlo+5+wq+EZ5Eo3Oh5QFzDNHBre/5ES?=
 =?us-ascii?Q?Kjd/fpcELkGGygO3dopCyY3PA1Rj8YFzgcF056gkPH1DUcuPxpLVNiPrZaSc?=
 =?us-ascii?Q?5VJ9OJwxHuKh2wGN890L6L9kdO7036EIpY4R2f0H98fBwSulnBEIBApj2rRx?=
 =?us-ascii?Q?5h/Hz1Y5ewr5ASPjIAPhIPd0xCSbncByesUApnAul9Fs1V/rw/V2EG5ObqW7?=
 =?us-ascii?Q?ynlPoEOLqgmt1OYbyqycMYvXTk99i5sGRbDkTNFTa1XDINu7ISX8CUFo2Fb6?=
 =?us-ascii?Q?c7eeIUwCwF9FeDSdANmrD9i/WYF5T3WfH3a1n8KVPh/UzM2EdbzMrhjOWc/e?=
 =?us-ascii?Q?21tBZBcVUC1xj3/c+ZsR5q2eZbbZ+LO9B5VxAcZ0o+xo5UooK2//vq511i30?=
 =?us-ascii?Q?vYORMHfhp6l2v6ch9czk+9iD1sDyB0EtXvL/yp9Oq6Lt1SqTjls2NLvEBrd3?=
 =?us-ascii?Q?AEnI43vv/EePq4I1Cmtb3aaQUGs+p++zIOJEDJQUq2OyN2RJydRbx18ou+4S?=
 =?us-ascii?Q?bNMAcvTFksCKys9UacfEs1NwbPtLIg6kqaBdHV4LClJWRgrPGUJrE/rW34JG?=
 =?us-ascii?Q?F0BCFK76CRx7eenB4mYSAqxyABhN34QHIblWII0STaEVw9fXjipeUeaiLW1p?=
 =?us-ascii?Q?xQ2VaAFzFNMnoKlHX1V/ELkSIyUzwI9IF2iX4yeyZCjc8Htws8FlTiWG7J2E?=
 =?us-ascii?Q?jrhClFfbF+I+XxY3yc8/o0XL54jqlvMq2LIgk3vzn67aQOgIYx0FMoTVnijt?=
 =?us-ascii?Q?7X5dMLgXerfGirEssX1BmCMvD7fbnqaCcZbNX1qgTDpRhnR+u9WOxRignuV+?=
 =?us-ascii?Q?NGcvtmTXEc0hLgzw1gMBEsJpKBHscjaRQBHZnvYsKBNoIaRJPE29szgfcuDU?=
 =?us-ascii?Q?4XE03kgwhSbadwoJ2zPzO9s1M7KNxtUqvmhX+H0oZXr1TGlsIWBBICsOO/NG?=
 =?us-ascii?Q?bgKAjocoAbkeYat5IhsvtcnFgWzz5JSMCpEvdy19jhvvurfPOoQlEdPYUvnt?=
 =?us-ascii?Q?RpV0Zc5XON+eDaj3iAePuywDKb3ox/yOATI2c1m2OoEF6T7/OzHBu1fDwtyb?=
 =?us-ascii?Q?DoUWP6Ttuom0ebs8Q1miZ3De7jjT0o4lZYikIWkid2kbnsoq9DPyYQ2LR0XG?=
 =?us-ascii?Q?uBLKy+gCKuvp1kwq92d2m6k/xc+Uejp4PedBZojoDf3hl4uLcIcuyoiwmwMy?=
 =?us-ascii?Q?Ngk9E/mfOHivsJf0Ua/W9dC3S7sNquJS8y7JM55JmzDZmgqZ1FYFXZWArz4/?=
 =?us-ascii?Q?E9aDJ5/f9wMEOOvtysS0+TXL19drFnCCWs/ZAggCYyOFSw1M6kYbS3OEVlNC?=
 =?us-ascii?Q?VbFtTWye2v3mv9b7nn7kdCj7R2AFxH8yyybc/PR1go5RVpMJ4LTTiK/P5FNX?=
 =?us-ascii?Q?j0ZQjH48qz/jskFQPX81nCRvPcEGNPnvGfobssa+u2SQ1BU+4LLBL88S8xGL?=
 =?us-ascii?Q?GOkdr+/j4dN1pB0N6iv2tA7DZS1THbdHmJ3SYk+nRfo2ILRriHVds2HYFpRq?=
 =?us-ascii?Q?lX92q/FWUz/MPXa5Btlv0ncFIxvPxOFpK3hzAXhx/emOF0+/x92p3WR6mivw?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6WsLlW/XTcP2dHxkAfGkOxU0wxhCGivQ16xTFSGaXIT12PcgwcAFlGvoimjrM+9NRpCrrwI1NKFwYgPpFDjIzDMQI0obBYycX9af4vxH0gsOM/CmOfobyxyjkfBu9ziJM/2LntnIRxGK1eiVKGaNU2kWetTRbnC7HeLU7ts35fJSCJFqhjcWVgrOcsjlT2d7L+Em5eBMPVdMB2Wfl182IzMmaZRJmiOwJgB1Fye+eQiHD9SsLNHW8ZRtTeK0L9FtCjdPTdAZvNFTro0VDEdLjEemMjzR1eDnutxQyUxyjgzVheGBC8Bj4xwVv9lhOqTIwBQwpUMhCwC78v5lrbPAdaQMTfyRQn7j8vIi6H/zqz6KXTcyE99OUQR4wqVNOMWxy+/Z6oGE+ivFn/QXQcJPnJFLCBUyX4wkrQml/OA8DQkfBKnGUlUCR4hOaEROxM7bS4meANJncRSvx9MElBOQNq2q6SqDxfAPLc2/G2qirpcUcs4gtCZ6KS8qjf+CkVRyexJ5pLgH0B88wshCuqF0RJp7nZaGCppYYNlDGDvBCOq31rLGqaJtdeW5aSFnA/258BCSXVivToSdzUrXH6vREy/sfbRF/KLI9X5IDvSNwSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd43266-0c0b-4e4e-c897-08dc22b41aa2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 23:26:51.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VafNQfhLWNHm9eP/K+/c/5PKS+GJ7vOPUXOhf9PFN4HfaieKZ52IpGh4j7VS21LgzDjw3BBNxrUEOPpzkYvAam/HGjjeOsQfqG8+vRv04o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=843 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310180
X-Proofpoint-GUID: DAW3it03hwCB-MXlHo-_i9x0QroPJsQU
X-Proofpoint-ORIG-GUID: DAW3it03hwCB-MXlHo-_i9x0QroPJsQU


Christoph,

> As the series is big enough it only converts two drivers - virtio_blk
> as a heavily used driver in virtualized setups, and loop as one that
> actually does runtime updates while being fairly simple. I plan to
> update most drivers for this merge window, although SCSI will probably
> have to wait for the next one given that it will need extensive API
> changes in the LLDD and ULD interfaces.

Looks nice in general and avoids the annoyances I had with my discovery
series wrt. discard. I'm in the process of rebasing that series to fit
on top of your changes and things get cleaned up nicely. We'll probably
have to coordinate the sd changes a bit.

Anyway. Great to finally get this resolved!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
