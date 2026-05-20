Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40ED36AB47;
	Wed, 20 May 2026 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308874; cv=fail; b=TD9y73JCKag69JobRsxRdubZNGGnmzLm7xfgoC8tdJl0iIAH+JE6nVKOhiy7I+AkqP+MkNYvL7O/rUd9qLDAuaKDsR5xjHqA9N9kVoDtFiyM9by4XkiheEr+kqKJqeY/e2tJOHavwTb81OvUUxesIFOdGIz4T/aE5tSXz3Lzj4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308874; c=relaxed/simple;
	bh=FcZAzFfgxxuA7p3O9DWpMd9QBVd45RUPbVIJ+a25zCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SeQ5uygsCzw6Uco9+1Dkt5cpQPgJAjPS6ir2Sret9EnfcQw83sjouP9YLz5mSBKtbS/msqtYC3ntKwYH7OOoGVSLnuHuMOETF4akRH9QgZV/+qbYlAWZf/8pvkA6I9nuhE/yNfpC7Q6YfXX5hfP+dA78kBeAzLtjK97EP74wz4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=djvuviy7; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="djvuviy7"
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDvpVS994809;
	Wed, 20 May 2026 16:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=F
	cZAzFfgxxuA7p3O9DWpMd9QBVd45RUPbVIJ+a25zCs=; b=djvuviy7JBvlY9uvH
	QfIigoFCbqqwfNeYaklGx8V9AHK9SwZ8BKC+IVe0gSOvTRzkrDcaZKUpbMx1p862
	1KPVVMBHI7bk7tZnc1Q20Oe5iAZ/5vDUZnzFVLvy8vc0u+Q9ZQldkq0w4Y2maxTT
	0er+fxsFoddNFGhiNRlGJ4Gz9+3Qb461b6tB7vshpfuf8IxKafGoDEiHsLg9NezK
	oOl2NGiC1kwRv8iRqEkK4TteB95gBRALlREyypVqGlK8pndZ4Go/D5Kvt5RHOFUp
	0xkRAOsMcc1ScD+y0UkcVnUfCPUeJWHQaVxmqho4P+dtv8fSLYjncmE8i0j0DvIa
	0H0lw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4e6k52evwa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 16:27:28 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKBBaB2828352;
	Wed, 20 May 2026 16:27:27 -0400
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4e9h8ptvv9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 16:27:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q880DMkI364/a1u0wt2377Lh3KBtX6PnNbO17vfpmbysKWvndusCOGjqISY+tRR3xKsWNaRI7Fj76A7y8P+fwhj2zCid7Wq4oX2ay/Vfc0U1t7+9qf/gFhqDel29QYcfUADzKfTncz7XhrlCKAWOrlAhVKlF05CuEJUgD/kvV0RcOhuu+RWEGitNxELJOIZQV9rSulNI0gDgnHYAILH5Cys8d7SadfGyTx+YHtjHzuySf+Pve6NpTfPn47R/daIwAcSlpp4NeTTYYli2mDhBNajSf+Pd/nJOpzYKNsH/O5DwPegsWAWa9ydTHX4Lx5i259mt1djMCLz0lcCye9NZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcZAzFfgxxuA7p3O9DWpMd9QBVd45RUPbVIJ+a25zCs=;
 b=Nt5HJd/+XdI3I8JDaOZ8s14skHNrQo4osWKFRbfB0AxbXgCD2Fdju5maKldIUtTKyKAIjGz1m7XAhXQKWXUY0VwkxzYUvHR/sC1o6PBSw64uAnyEP8StwvIGaY7lr6jgoK0P9MyObZxNLZ138820xQq/YV8XMEPvemQPD0uXo0i81ZQu6IELO+ptq3o78s7IwbZHNW2naTBuGA5H4gFzXDhuX0OVbpfE3zcGyuJ1Fxn+82/KJWEfGyRQYXp/5d7I+M/XwymGtpomqPyaAvXmWph7OTQTcjP2vJSEUYELy8yE1/qZ6dpJQULMj2YHRhHfYjawTCSQP/pSDMQ6DPHwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from MW4PR19MB5493.namprd19.prod.outlook.com (2603:10b6:303:18e::20)
 by SABPR19MB997526.namprd19.prod.outlook.com (2603:10b6:806:50e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 20:27:24 +0000
Received: from MW4PR19MB5493.namprd19.prod.outlook.com
 ([fe80::1e95:d94d:29eb:fe85]) by MW4PR19MB5493.namprd19.prod.outlook.com
 ([fe80::1e95:d94d:29eb:fe85%6]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 20:27:24 +0000
From: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
To: Keith Busch <kbusch@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Topic: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Thread-Index: Adzm1dy/Cx6JquSnSUq/8UuX73jm6QAJeqaAAAMgw3AAAhErAABhS0VA
Date: Wed, 20 May 2026 20:27:24 +0000
Message-ID:
 <MW4PR19MB5493606E49C417CDDF97392CFD012@MW4PR19MB5493.namprd19.prod.outlook.com>
References:
 <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <agtnJb5a5uIqH-65@kbusch-mbp>
 <MW5PR19MB5484B015B6B1D739D8C5CA2FFD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <aguKAgkCUOVL2pVk@kbusch-mbp>
In-Reply-To: <aguKAgkCUOVL2pVk@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-05-20T20:17:51.0000000Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR19MB5493:EE_|SABPR19MB997526:EE_
x-ms-office365-filtering-correlation-id: ec61a253-0972-4875-fd81-08deb6ae3403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|786006|366016|22082099003|56012099003|4143699003|18002099003|11063799006|5023799004|3023799007|38070700021|6133799003;
x-microsoft-antispam-message-info:
 JmjedsFcTb7mBK9B7SCQYaiPY529hWJ7N6JAleOz4F5ImzvAmrQFsm44J90YkZiFS0yRTbW+dF0lD3fl1JnjuEYz1Bq1sCsASNw45kpgUedB9MLcRA4iFCe72xMhkgLs8Nus5g+NU3DTGmMzOibjQYdNeY0aKOqAyASsQMnLZNHwi6sc0vZSmh+pdZSLkkojfiSA+94Canmk82ZBtXw+DlIjP9HSr+Zk7mDe51gpnPSedpbqsnQLQ9fK7u4qd4Iy95Xhqgl27X4XegpurLXIYLFd5GWwezGSFbWb4fitD9mDWT6rAEVw0NyBd+5+etNSu0OJ6+MGuM2jcEPfqLnM1MmBgsc57BbTFSiWQXshu8qtXMPGeepl66QOyeF2YFOUtv0efUkPv1M5w+3m/MuLeZGZwsjuV/5CUShEd9mTR3PrEDymdJG6T9OuJj5l2dGktbgZ6zBDtkFcGgbRsUUDI8mw0Vazq8VXzKQ4D97tymAY/yS3TlFxfCHPCIYiexhdkPlJ+IJr7YaLq5YXD1VsQQ+Ao5RQK8XHF/UuxOxyGQ9BMIcFp7MTzMPCDlLFRGZZ2flhnFULEU7nF2T1E4lTo1zk020KPbROYkdOg6HOEdKbCokaj852u6QUKgaggeOAhgZkmfrxhi4WUXKfh/uJ/hxQGErQxZqg8wEil3+9aeftRvhoWQSPo5ewOuiMydfobxCUuxT4946Rlud6WB43JgYJ+lXRHR2lqhzuNqZqRu/aPWGPLKa3YgvwG/il4jY0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR19MB5493.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(786006)(366016)(22082099003)(56012099003)(4143699003)(18002099003)(11063799006)(5023799004)(3023799007)(38070700021)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlJUSXhjUERKR3pvVkhpTGJrcjhaUGh0ZVlHQUVLaUpSMUlCd0dmOHNtODFI?=
 =?utf-8?B?MXJuZzFXamJOc2FhTGRmWWp2eVorWXQwcnhuODU0WVlZWHFDM2l5M3FuKzB6?=
 =?utf-8?B?cENBL3gxR3BVWW1pYUI5a2VXbEdpQk1ETFI1UW1ScittZzJtaUM1U2VvY1VR?=
 =?utf-8?B?aUZLWE9ZWWdzK0Z0QWUybmNDN1FLbjlGVGtSa2FTa2loby9KOTNhV1d1TVQ0?=
 =?utf-8?B?aklHbWkzWW00MmhjUG5NWHFwbUFVeUVBcytVYlBBcWhZRVgrejBDV0FLdEhm?=
 =?utf-8?B?bkdpVVgzUm1ualZpK0JMcGpWM01kSWpFWC83aEpnSUg1U20vNVp0eDhENlJH?=
 =?utf-8?B?eWlrTVVqZllGWTlnWkNCSnFzdE90QUtobCt1Z0h0Z0VUUHVxSExyV1Vham50?=
 =?utf-8?B?N1NwN0VHL05yalNqdjZ0aUN4UWYzU1JTb0g1SVdxUU1HTTliS3RaK2tuVTdX?=
 =?utf-8?B?bVo3bWRRRnAzaVk5WUpHZVN1dTU0SXlHWGU3eGVDR1lOUklaSDNRSS9mditV?=
 =?utf-8?B?cTNFQ1hrdkliK0dZeUFpU1VNKzVNNjJSNXo4dGZEc3llQzJLOU53TVJvajM3?=
 =?utf-8?B?SnkrQzQ2L1g3YlBhY3Y4TG5KbWYxcVA4NFNRbzBMY3o2U3B4RTJJcFVnVVFG?=
 =?utf-8?B?T09qc0F2UDZBK3VMa1lDMUlmNGd6OTVwRWliblVuQmg0c0tzWFBGT3cydmIw?=
 =?utf-8?B?UGozMDc0OFoyYTJZZ2dHZmg3cmRkeVdpcjV4dzBQbi9iMUdjWmx5cmdOWWdw?=
 =?utf-8?B?eTVaZ29xd3JPMjd1YjQ4U2NOVkpGMEhTY3U5WURNa3pldElMNHFkUjQxQW9s?=
 =?utf-8?B?YlE2RmtsVTZ5aHplNkdZMlhBTzZYQmd5Z2JrSXNSdDRWbVMxUjR5L2hnMmc4?=
 =?utf-8?B?SGpDaDI1KytwWC9oZmxFMTlTTWRPV3RQdVRwTk9qM1JlUTRPN2ZzR25obTFm?=
 =?utf-8?B?OFhpNWFBemczTk9udWhBZUlUOUhEeG9XcEpDWFVjYWpzOGNwaG4wb2RHdTdQ?=
 =?utf-8?B?WjBJN1NuOEZSdG0xNCtLbUpYRGRrcEtNQnZPVUNsL1BMWlRmdm1uR2J2NGJz?=
 =?utf-8?B?Wm40WjNSS0prbGtFR0QycGFyZjI4aTk2UEdOZ05WUndVekhCOVU3MW51MWtU?=
 =?utf-8?B?SnhWV1ViVkJMMFNUZVJydFlCbWtmNmpOdklIZ08yOTJFaUNMdkQ5NzBKMVhI?=
 =?utf-8?B?NjJ4RTNDUDZ4eXRlenBRc3ZTa21qYytvSDlEYlV5cUQ3RnRyaUdhV0VqcFRL?=
 =?utf-8?B?QXVEQys4ZXo5QmJCQlV1V2M3MnFRd215MjRWK2RKa3NPZmJyR1B4K3pJbzVo?=
 =?utf-8?B?SHVxZDlpSlZxWVZrM055dmhXZGFBM3NUTkxZZElheW8rYzYvUkh1TXB0TkpU?=
 =?utf-8?B?Tmd2L011OGpiUWFlTjlEOFVZNVh3blNIS0g3ZnRUdXB4aGFZUGU3SXo5aXBD?=
 =?utf-8?B?V0JnK3BTSnNGNzh5b3FYeFB3OVM2QVlwUGhqUk5iZDJacnJqaFNBaDh6SHMy?=
 =?utf-8?B?ekRCL0hzL3hHSXVMYlFlVnBPdHVDUm4xK3BJSFlwVWZsczZnNU9WTVFJc2cx?=
 =?utf-8?B?SEhSQ3VodW5VT3d5QTBtaDc4ME1CY0srVlZDc0JCL2ZyMnJpbEViazUxcE9p?=
 =?utf-8?B?VEIwOXRXRjhyNU9oSWF4VWxYM2gxdlRBc1FjOExuREhSd0R1YnNYVzBkRWtC?=
 =?utf-8?B?WHAveGRFOE80SDRkYnFtWkhvTXp6RkRMWGUzZmE0SmYwOTFqVUpueFdBYUlz?=
 =?utf-8?B?aldwTjU1M014MjNRZlNWYW84ZEo5NVFDNTM3L1k2Mng3UXlsUGN4ZmpLSW9K?=
 =?utf-8?B?Yk0yVjdJSUhtZHExUWo3M0UwVGkwdSsvb3B2a0Y5TGpWazdPcnFZcER5ZEVQ?=
 =?utf-8?B?aVhVb2Q0T09VVnF1UklTdkNVTWNVeXpUMXRrd3ozNGNJdkNSa1NBRTIvZmFp?=
 =?utf-8?B?NHFKa1FoRXRnUFBTN1RNcjNYcTZrUkVQS2pRaEpKaERlT3FxNWZGdWJ2Sk50?=
 =?utf-8?B?TVdjZVdyeitHS3loZ3BtMDQ3dU0rbGZVYkZuQm1KTGZBZVRMUkFVV285andk?=
 =?utf-8?B?dzExL3pwUEs2ODNRd3RIZWtlcGVaM2xzdi8vNmRQdU9xeTF1ZUdvd1JZemow?=
 =?utf-8?B?dlBOMzBuY3MrL0lWSlhjcERPdUYzQUxRdWRVV2xTd3pYQ3FwakVoSExibjc0?=
 =?utf-8?B?YzliSWlmcUp1R1hnRGxuTnlqMFQwRXVIOEUza1VzZWNzMjhvVEhrSG13Zlhh?=
 =?utf-8?B?Ykd0Rlo2YjdEd1dlRzJHSHlQWWxGdkhidWhLRjZ3b01DM251ZmFHNFpFbU1x?=
 =?utf-8?B?L1NiS25ORGcrNTlYNUovT1BtOGFPblVQallKZ2FiWW9iWVZVaFJ6UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	m/RoVAlf6FEIbaHStn4htLoBSKxCSTBUNI27t3dGO8IvzRheuY0j7QjEcecUl/7YrCkGYsnPsVf3L0hrvC2NlHuElovoFRJhUg3RWqpQCPdvRkCPU5yaESbPPwlO/osICWgvm1QFOggez5WEO7vrbdVPAn5cKrUp8qCEd6WeN/vKru3bcw3QHPvQjT8MhgEwftarsNMhJtHRI8UHIz21b0sCXDDeSmpEMh9ESJJ1m5FKLDSAlHqTfoqNIrdGFIT3yGKkNr3+rJLI7wmaaQE5Y8NrnQ6Cxced21zDH6DrqSYsN3OO7rn/voWGEORXbva/sFL2pyg9uIi/HBWAe1lShw==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR19MB5493.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec61a253-0972-4875-fd81-08deb6ae3403
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 20:27:24.5796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySSDoSMgh+8g6rP2cniTlgF0BT8a1KUp65ikhQ2gvfiMFTySH1zOZv5K53hDZMmu+i2OP40qPBhfF3OsQAD42g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR19MB997526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200200
X-Authority-Analysis: v=2.4 cv=QpNuG1yd c=1 sm=1 tr=0 ts=6a0e1930 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=gLxAKuEMs0EQMVFiDJnH:22 a=QcBYhpoLRXuLkjg0LXYA:9 a=QEXdDO2ut3YA:10
 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: q0_MB5ECZpETzMMLKCym9e8C2S3jJCY-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIwMCBTYWx0ZWRfX+hCwCiwlrx12
 IwqkVP0DXFF4/r+yTHZiSKofBxkrIZOuOQW427ov467so6utNgFXwF8R4mQmfgdDIHSqEhW9GP1
 kSybEQf51869tQbi+Sd2OVHKpa+G06IvfOfpkhMn0MtLx8KNeaK7t6TpLbg9TwovTLg6rNj8wp2
 Z+f+oUAIV3mgsV3MkwDR7rnY2dslnLt5pNsj0VnlrDih8FKfCyFL8UH9i0+HJUwHKGxzm7t39NP
 wTxaxiII43aKlJqa1DkrC7YeCpoe/kjKymkkQvze/+n8qYMBtWb+s9RXXoM595SwKZbpbb/FNEG
 moTKdj9VD2Slg7AEtYcaAgS6Ic0aivHD+FRTim8zMbcXN5fsepiCoHvYW7j3vqABGHG4D0ze41A
 pmLfyC1NCZqHy/rTAXZkItQnuWzvHu23EA02rfzMEH9aG0uHAIvcNwS/Yaz+bSRCyKMK51hdEFj
 uNCgjPF7l/HVqIXTWAA==
X-Proofpoint-GUID: q0_MB5ECZpETzMMLKCym9e8C2S3jJCY-
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200200

DQpJbnRlcm5hbCBVc2UgLSBDb25maWRlbnRpYWwNCk9uIE1vbiwgTWF5IDE4LCAyMDI2IGF0IDAz
OjUyOjA5UE0gLTA2MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBNb24sIE1heSAxOCwgMjAy
NiBhdCAwODo1OTowOVBNICswMDAwLCBBY2hraW5hemksIElnb3Igd3JvdGU6DQo+ID4gLSBzdWJt
aXRfYmlvX25vYWNjdF9ub2NoZWNrIGlzIGJsb2NrLWludGVybmFsIGFuZCBub3QgZXhwb3J0ZWQs
IHNvIHVzaW5nIGl0DQo+ID4gZnJvbSBOVk1lIHdvdWxkIHJlcXVpcmUgYSBibG9jay1sYXllciBB
UEkgY2hhbmdlIGp1c3QgZm9yIHRoaXMuDQo+DQo+IFRoYXQgaXMgbm90IGEgdmFsaWQgcmVhc29u
IHRvIG5vdCBkbyB0aGlzLiBXZSBvZnRlbiBleHBvcnQgYW5kIHVuZXhwb3J0DQo+IEFQSXMgYXMg
bmVlZHMgZXZvbHZlLiBJJ20gbm90IHNheWluZyB5b3UgaGF2ZSB0byB1c2UgdGhpcyBBUEksIGJ1
dCBJJ20NCj4ganVzdCBub3QgeWV0IHNlZWluZyB3aHkgd2Ugc2hvdWxkbid0Lg0KDQpGYWlyIHBv
aW50DQoNCj4gPiAtIGl0IGJ5cGFzc2VzIG1vcmUgY2hlY2tzIHRoYW4gSSBzZWUgd2UgbmVlZCBo
ZXJlICh0aHJvdHRsaW5nLCBSTywgY3J5cHRvLA0KPiA+IG9wLXR5cGUpLCBJIHByZWZlciBieXBh
c3Npbmcgb25seSB0aGUgRU9EIGNoZWNrLg0KPg0KPiBJIGRvIG5vdCB0aGluayB3ZSBuZWVkIGFu
eSBvZiB0aG9zZSBvbiB0aGUgaGlkZGVuIGRldmljZSBlaXRoZXIuIFRoZQ0KPiBzdGFja2VkIGxp
bWl0cyBzaG91bGQgaGF2ZSBjYXVnaHQgYW55IHByb2JsZW1zIG9yIGhhbmRsZWQgYW55IHBvbGlj
eSBvbg0KPiB0aGUgZmlyc3QgcGFzcy4NCg0KQWdyZWVkLCBob3dldmVyIEkgd2FudCB0byBwb2lu
dCBvdXQgdGhhdCBFT0QgbWlnaHQgYmUgc3BlY2lhbCBzaW5jZSB0aGUNCmNhcGFjaXR5IGNhbiBj
aGFuZ2UgYXN5bmNocm9ub3VzbHkgYmV0d2VlbiBwYXNzZXMgYmVjYXVzZSBzZXRfY2FwYWNpdHko
MCkNCmluIG52bWVfbnNfcmVtb3ZlKCkgcnVucyBiZWZvcmUgc3luY2hyb25pemVfc3JjdSgpLCBu
b3QgYWZ0ZXIuDQoNCj4gPiAtIEJJT19SRU1BUFBFRCBwcm9wYWdhdGVzIHRvIHNwbGl0IGNsb25l
cywgc28gaXQgY292ZXJzIGFsbCByZXN1Ym1pc3Npb25zLA0KPiA+IG5vdCBqdXN0IHRoZSBpbml0
aWFsIG9uZS4NCj4NCj4gU3VibWl0dGluZyBzcGxpdCBjbG9uZXMgYWxyZWFkeSB1c2VzIHN1Ym1p
dF9iaW9fbm9hY2N0X25vY2hlY2soKSBzbyB0aGUNCj4gQklPX1JFTUFQUEVEIGZsYWcgZG9lc24n
dCBjb21lIGludG8gcGxheSB0aGVyZSBlaXRoZXIuDQoNCllvdSBhcmUgcmlnaHQsIG9uIGN1cnJl
bnQgbWFpbmxpbmUgKHNpbmNlIGNvbW1pdCAwYjY0NjgyZTc4ZjcgImJsb2NrOg0Kc2tpcCB1bm5l
Y2Vzc2FyeSBjaGVja3MgZm9yIHNwbGl0IGJpbyIpIHNwbGl0IHJlbWFpbmRlcnMgZ28gdGhyb3Vn
aA0Kc3VibWl0X2Jpb19ub2FjY3Rfbm9jaGVjaygpLiAgVGhlIHNwbGl0IHBhdGggd2FzIHRoZSB0
cmlnZ2VyIG9uIHRoZQ0Kb2xkZXIgcHJvZHVjdGlvbiBrZXJuZWxzIHdoZXJlIHdlIG9ic2VydmVk
IHRoZSBmYWlsdXJlcyAoNS4xNCwgNi40KSwNCndoZXJlIHNwbGl0cyBzdGlsbCB3ZW50IHRocm91
Z2ggc3VibWl0X2Jpb19ub2FjY3QoKS4NCg0KTG9va2luZyBhdCB0aGlzIG1vcmUgY2FyZWZ1bGx5
LCB0aGUgcmFjZSBzdGlsbCBleGlzdHMgb24gY3VycmVudCBtYWlubGluZQ0KdGhyb3VnaCB0aGUg
aW5pdGlhbCBzdWJtaXRfYmlvX25vYWNjdCgpIGNhbGwgaW5zaWRlDQpudm1lX25zX2hlYWRfc3Vi
bWl0X2JpbygpIGl0c2VsZiwgbm90IGluIHNwbGl0czoNCg0KICBudm1lX2ZpbmRfcGF0aChoZWFk
KQ0KICAgICAgICAgICAgICAtLSByZXR1cm5zIG5zLCBOVk1FX05TX1JFQURZIHdhcyBzZXQNCiAg
ICAgICAgICAgICAgLS0gbnZtZV9uc19yZW1vdmUoKSByYWNlcyBpbiBoZXJlOg0KICAgICAgICAg
ICAgICAtLSAgY2xlYXJfYml0KE5WTUVfTlNfUkVBRFkpDQogICAgICAgICAgICAgIC0tICBzZXRf
Y2FwYWNpdHkobnMtPmRpc2ssIDApDQogICAgICAgICAgICAgIC0tICBzeW5jaHJvbml6ZV9zcmN1
KCkgYmxvY2tzICh3ZSBob2xkIGl0KQ0KICBiaW9fc2V0X2RldihiaW8sIG5zLT5kaXNrLT5wYXJ0
MCkNCiAgICAgICAgICAgICAgLS0gY2xlYXJzIEJJT19SRU1BUFBFRA0KICBzdWJtaXRfYmlvX25v
YWNjdChiaW8pDQogICAgICAgICAgICAgIC0tIGJpb19jaGVja19lb2QoKSBzZWVzIGNhcGFjaXR5
PTAsIGZhaWxzDQoNClRoZSBTUkNVIHJlYWQgbG9jayBwcmV2ZW50cyBzeW5jaHJvbml6ZV9zcmN1
KCkgZnJvbSBjb21wbGV0aW5nLCBidXQgaXQNCmRvZXMgbm90IHByZXZlbnQgc2V0X2NhcGFjaXR5
KDApIGZyb20gZXhlY3V0aW5nLiAgU28gdGhlIGJpbyBjYW4gZmFpbA0KdGhlIEVPRCBjaGVjayBv
biB0aGUgcGVyLXBhdGggZGV2aWNlIHdoaWxlIHdlJ3JlIHN0aWxsIGluc2lkZSB0aGUgU1JDVQ0K
cmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb24uDQoNCg0KPiBBbmQgQklPX1JFTUFQUEVEIGFwcGxp
ZXMgdG8gd2hlbiB0aGUgYmlvJ3MgYmRfcGFydCBpcyBhIHBhcnRpdGlvbi4gVGhlDQo+IG11bHRp
cGF0aCBsYXllciBvdmVycmlkZXMgdGhlIGJsb2NrIGRldmljZSB3aXRoIHRoZSBwYXJ0MCBvZiB0
aGUgcGF0aCwNCj4gc28gdGhlcmUgaXMgbm8gcGFydGl0aW9uIChhbmQgd2UgbWF5IG5vdCBoYXZl
IGJlZW4gZGVhbGluZyB3aXRoIGENCj4gcGFydGl0aW9uIGluIGZpcnN0IHBsYWNlKSwgc28gdGhp
cyBwYXRjaCBpcyBpbnRyb2R1Y2luZyBhIG5ldyBpbXBsaWNpdA0KPiBleHBlY3RhdGlvbiBvbiB3
aGF0IHRoaXMgZmxhZyBtZWFucy4NCg0KSSBhZ3JlZSB0aGlzIHNvdW5kcyBsaWtlIG92ZXJsb2Fk
aW5nIG9mIHRoZSBCSU9fUkVNQVBQRUQgZmxhZyB0aGF0IHdhcw0KaW50cm9kdWNlZCB0byBza2lw
IHBhcnRpdGlvbiByZW1hcHMuICBIb3dldmVyIHNraXBwaW5nIGJpb19jaGVja19lb2QNCmFuZCBi
bGtfcGFydGl0aW9uX3JlbWFwIGlzIHdoYXQgaXMgbmVlZGVkOiB0aGUgcGVyLXBhdGggZGV2aWNl
IGlzIGFsd2F5cw0KYSB3aG9sZSBkaXNrIHNvIHNraXBwaW5nIGJsa19wYXJ0aXRpb25fcmVtYXAg
aXMgYSBuby1vcCwgYW5kIHNraXBwaW5nDQpiaW9fY2hlY2tfZW9kIGlzIGludGVudGlvbmFsIHRv
IGF2b2lkIHRoZSBmYWxzZSBJTyBlcnJvci4gIFRoaXMgaXMgdGhlDQpzYW1lIHBhdHRlcm4gYXMg
Y29tbWl0IDNhOTA1YzM3YzM1MSAoImJsb2NrOiBza2lwIGJpb19jaGVja19lb2QgZm9yDQpwYXJ0
aXRpb24tcmVtYXBwZWQgYmlvcyIpIHdoaWNoIHVzZWQgQklPX1JFTUFQUEVEIHRvIHNraXAgRU9E
IG9uDQpyZXN1Ym1pc3Npb24gYWZ0ZXIgcmVtYXBwaW5nLg0KDQpJIGRpZCBub3Qgd2FudCB0byBh
ZGQgYSBuZXcgYmxvY2stbGF5ZXIgZmxhZyBmb3IgYSBzaW5nbGUgY2FzZSB0aGF0DQpuZWVkcyB0
aGUgZXhhY3Qgc2FtZSBiZWhhdmlvciB0aGUgZXhpc3RpbmcgZmxhZyBwcm92aWRlcy4NCg0KPiBD
b25zaWRlciBhIHJlYWwgZmFpbG92ZXIgZ29pbmcgdGhyb3VnaCB0aGUgcmVxdWV1ZV9saXN0IHVz
aW5nIHRoZQ0KPiBzdWJtaXRfYmlvX25vYWNjdCgpIGFnYWluLiBJZiB5b3UndmUgYWxyZWFkeSBz
ZXQgQklPX1JFTUFQUEVELCB0aGVuIGl0DQo+IHNraXBzIHRoZSBjaGVja3MsIGJ1dCB0aGF0IGNv
dWxkIGhhdmUgaGFwcGVuZWQgYWNyb3NzIGEgY29udHJvbGxlcg0KPiBmb3JtYXQgY2hhbmdlIHRo
YXQgbW9kaWZpZWQgYWxsIHRoZSBsaW1pdHMsIHNvIHlvdSBwcm9iYWJseSB3YW50IHRoZSBlb2QN
Cj4gY2hlY2tzIHRvIGhhcHBlbiBhZ2FpbiBvbiB0aGlzIHNjZW5hcmlvLiBZb3VyIHN1Z2dlc3Rp
b24gd291bGQgc2tpcCBpdA0KPiBiZWNhdXNlIHlvdSdyZSB1c2luZyBCSU9fUkVNQVBQRUQgYXMg
YSBwcm94eSB0byBza2lwICJlb2QiIGNoZWNrcy4NCg0KSSBzZWUgdGhhdCB0aGUgZmFpbG92ZXIg
cGF0aCBjbGVhcnMgQklPX1JFTUFQUEVEIGJlZm9yZSB0aGUgYmlvIHJlYWNoZXMNCnRoZSByZXF1
ZXVlIGxpc3QuICBudm1lX2ZhaWxvdmVyX3JlcSgpIGNhbGxzIGJpb19zZXRfZGV2KCkgb24gZWFj
aCBiaW8NCnRvIHJlZGlyZWN0IGl0IGJhY2sgdG8gdGhlIG11bHRpcGF0aCBoZWFkOg0KDQogIHZv
aWQgbnZtZV9mYWlsb3Zlcl9yZXEoc3RydWN0IHJlcXVlc3QgKnJlcSkNCiAgew0KICAgICAgLi4u
DQogICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmbnMtPmhlYWQtPnJlcXVldWVfbG9jaywgZmxhZ3Mp
Ow0KICAgICAgZm9yIChiaW8gPSByZXEtPmJpbzsgYmlvOyBiaW8gPSBiaW8tPmJpX25leHQpDQog
ICAgICAgICAgYmlvX3NldF9kZXYoYmlvLCBucy0+aGVhZC0+ZGlzay0+cGFydDApOyAgLyogY2xl
YXJzIEJJT19SRU1BUFBFRCAqLw0KICAgICAgYmxrX3N0ZWFsX2Jpb3MoJm5zLT5oZWFkLT5yZXF1
ZXVlX2xpc3QsIHJlcSk7DQogICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZucy0+aGVhZC0+
cmVxdWV1ZV9sb2NrLCBmbGFncyk7DQogICAgICAuLi4NCiAgfQ0KDQpUaGVuIG52bWVfcmVxdWV1
ZV93b3JrKCkgY2FsbHMgc3VibWl0X2Jpb19ub2FjY3QoYmlvKSB3aXRoIEJJT19SRU1BUFBFRA0K
YWxyZWFkeSBjbGVhcmVkLCBzbyBiaW9fY2hlY2tfZW9kKCkgcnVucyBub3JtYWxseSBvbiB0aGUg
bXVsdGlwYXRoIGhlYWQuDQpJZiBhIGNvbnRyb2xsZXIgZm9ybWF0IGNoYW5nZWQgdGhlIGNhcGFj
aXR5IGluIGJldHdlZW4sIHRoZSBFT0QgY2hlY2sgb24NCnRoZSBtdWx0aXBhdGggaGVhZCBjYXRj
aGVzIGl0Lg0KDQpJIHNlZSBmcm9tIHlvdXIgInZhbGlkYXRlIGJpb3MgYWdhaW5zdCBxdWV1ZSBs
aW1pdHMiIGRpc2N1c3Npb24gdGhhdA0KQ2hyaXN0b3BoIEhlbGx3aWcgc3VnZ2VzdGVkIGVsaW1p
bmF0aW5nIHRoZSB1bmNvbmRpdGlvbmFsIHNldF9jYXBhY2l0eSgwKQ0KZW50aXJlbHkgYW5kIHlv
dSBhcmUgZXhwbG9yaW5nIHdoZXRoZXIgdGhlIEdEX0RFQUQgY2hlY2tzIGFyZSBzdWZmaWNpZW50
DQp0byByZXBsYWNlIGl0LiBUaGF0IG1pZ2h0IGJlIHRoZSByb290IGNhdXNlIGZpeC4NCg0KWW91
IGFsc28gbm90ZWQgaW4gdGhlIG1lbnRpb25lZCB0aHJlYWQgdGhhdCBCSU9fUkVNQVBQRUQgZG9l
cyBub3QgY292ZXINCmJpb19xdWV1ZV9lbnRlcigpIC0+IEdEX0RFQUQgLT4gYmlvX2lvX2Vycm9y
KCkgcGF0aC4gIFRoYXQgaXMgdHJ1ZSwgYnV0DQpJIHRoaW5rIGl0IGlzIGEgc2VwYXJhdGUgcmFj
ZS4gIFRoZSBlcnJvciB3ZSBzYXcgaW4gb3VyIHRlc3RzIGlzDQpzcGVjaWZpY2FsbHkgYmlvX2No
ZWNrX2VvZCgpOg0KDQogICAgImF0dGVtcHQgdG8gYWNjZXNzIGJleW9uZCBlbmQgb2YgZGV2aWNl
Ig0KICAgICJudm1lMWM5bjE6IHJ3PTMzNTU2NDgwLCBzZWN0b3I9NDc2MTYwLCBucl9zZWN0b3Jz
PTI1NiBsaW1pdD0wIg0KDQpCSU9fUkVNQVBQRUQgYWRkcmVzc2VzIHRoaXMgcmVwb3J0ZWQgZmFp
bHVyZS4gIElmIHJlbW92aW5nDQpzZXRfY2FwYWNpdHkoMCkgZnJvbSBudm1lX25zX3JlbW92ZSgp
IGdvZXMgaW4gYXMgcGFydCBvZiB5b3VyIFJGQw0Kc2VyaWVzLCBpdCBmaXhlcyBib3RoIHJhY2Vz
IGFuZCB0aGlzIHBhdGNoIGlzIG5vdCBuZWVkZWQuICBVbnRpbCB0aGVuLA0KdGhpcyBwYXRjaCBw
cm92aWRlcyBhIG1pbmltYWwgZml4IGZvciB0aGUgYmlvX2NoZWNrX2VvZCgpIGNhc2UgdGhhdCBp
cw0KYmFja3BvcnRhYmxlIHRvIHN0YWJsZSBrZXJuZWxzIGFmZmVjdGVkIHRvZGF5Lg0KDQpJIHdp
bGwgc2VuZCBhIHYyIHdpdGggYW4gdXBkYXRlZCBjb21taXQgbWVzc2FnZSB0aGF0IGNsYXJpZmll
cyB0aGUNCnByaW1hcnkgcmFjZSBhbmQgZHJvcHMgdGhlIGFyZ3VtZW50cyB5b3UgcmlnaHRseSBw
b2ludGVkIG91dCBhcmVu4oCZdA0KdmFsaWQuDQoNClRoYW5rcywNCklnb3INCg==
