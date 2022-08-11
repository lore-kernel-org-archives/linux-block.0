Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3D8C19F2A
	for <linux-block@archiver.kernel.org>; Thu, 11 Aug 2022 11:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiHKLce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Aug 2022 07:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiHKLbx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Aug 2022 07:31:53 -0400
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD72E13F06
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 04:31:41 -0700 (PDT)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BAEqB4025154;
        Thu, 11 Aug 2022 07:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ozI9Lq8VxzrllA3LcLKpyI5WyNSGu3AwPnL3bcGafQU=;
 b=f0AfPm9/XzndXooeYQneL/jcwMWqIlU+CC7vtstxjcHuT09pH+6qh3NA4T0b13fYUw7Q
 Zo+LWZSjXDfPq70CicYzs/PtnY6HTXFOdICjkvlCMKN2j1jqaNiv4D3wDEP7A2PsBO8R
 mr1jsnQp4wANrdBLwtmcmKwlJDO5IzMWyPM1GfwAwAAGRAP5oBW06dGTJ7WgDFNoOD8i
 r/dr+GSn0pYKDQaKAvzbtKzP80JpLuY5Dqds3XHUTo2m57RFO5NrZFxY9SAn/hxF2fBd
 OzzwU5dkrj4cgJAOBhMg7Ikvcgkrzp4SpzDAA1hWtU0iskT+nt4DDAml8SZTAA8b5zEy LA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3huwr48hbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 07:31:26 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BBTHCZ031237;
        Thu, 11 Aug 2022 07:31:26 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3hvxmr21fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 07:31:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHyzFT2eTnE7TeEDrh9hA6tjqpqmS4fWdOo3PkL5+P7Fg+k+aNaUlfyz4UuG35lbN6pyVCRnPCNObG4H8/ZVvxHRbQm5LOso1fSkmtCdYMcaAsf9zEHLEapLFyLQG+Pc4DZoKiF2uz0uyGaDxnBdB2MU45TTCU+k3A7m2gfIikDxSNErQbLRPn11aNjGrK+6HWmY8DpNf7vF2ljA00JVTr5ZCvqs/Vr1lUEWP79MWpjaPP1br4/CelThG8kNXhUUmfGcvOEfGtUD9gMOFGst3OcRfYYfKg3l89LM1ZaweISyJtQCuD/X2M8sdHrHtsSKpY2iYv/wmu4ZlImrLeCL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozI9Lq8VxzrllA3LcLKpyI5WyNSGu3AwPnL3bcGafQU=;
 b=T34cHl+DpKJUyIOaCF12HBp+7c9QCkrJVWizH++vupm3yEADHytJSLkyJrJHdKGBIZc58na8y4mBthBAnsIPQ2l7Zn9BqnGL7fbyzivohHVQbXeKBnELIKGBZd8kTAUOg3bVEXF07GQ4/eP3TVLZtehQ64/itMM+tm95ne2zSob69Q3mmB4Gbh7bDSfRI2Uy/h58uW8sBAoqGhoifAB/LpZeo2+7kvcb/D3tLQ4ENfgWnHZ4Z7fSlcwBNPlr4dzmbKqcg4RPewkkGPxXZ1HK8hK9o7IUdIeqB/lIlmURlur6quQMeLpxRigKP1v16xGUadB8dl/7soVsdjd/B8CZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by SJ0PR19MB5448.namprd19.prod.outlook.com (2603:10b6:a03:3d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 11:31:22 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::5ca9:af39:ce69:34e8]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::5ca9:af39:ce69:34e8%3]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 11:31:22 +0000
From:   "Belanger, Martin" <Martin.Belanger@dell.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
CC:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: RE: [bug report][bisected] blktests nvme/tcp nvme/030 failed on
 latest linux-block/for-next
Thread-Topic: [bug report][bisected] blktests nvme/tcp nvme/030 failed on
 latest linux-block/for-next
Thread-Index: AQHYp1hHwIQsP1xhVEyJNVNK9FScMa2dkjyAgADuIYCAAIlHYIAAhDGAgAnvDACAABxPwA==
Date:   Thu, 11 Aug 2022 11:31:22 +0000
Message-ID: <SJ0PR19MB4544485314F5FDAF0159C0ABF2649@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <CAHj4cs_7kR6DXi19CWh3veespFT=cJSTD0YGEFt8tw_Y8fEqZA@mail.gmail.com>
 <CAHj4cs8zXRTPpHt0Xu5BtSGtERK8cgniwrRPygEL9R=6qxjT5w@mail.gmail.com>
 <3af8153e-5e7a-f803-4dd4-cf7088a9d7d4@nvidia.com>
 <CAHj4cs90B+=Sjr43Xf+DWXw=oMCFLNPmMdenhyQn9fG=-ZXtVA@mail.gmail.com>
 <SJ0PR19MB45449CEC5FCA24EBE6C9BB90F29F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <CAHj4cs82ssuVX25yeHXhtqkkApxJbWDaoyOgq=0u5C4LWF2btg@mail.gmail.com>
 <53ed5142-f9ee-f373-25fc-69c14bc372b3@grimberg.me>
In-Reply-To: <53ed5142-f9ee-f373-25fc-69c14bc372b3@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-08-11T11:17:36Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=eb1709c8-cb8a-41c9-bddc-515afb09aeed;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66274243-61e9-4863-0fee-08da7b8d04d9
x-ms-traffictypediagnostic: SJ0PR19MB5448:EE_
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7D4gKDnZwqJSv/RTOw99Z6+tpTQ/OIHdiOhqAKx5/Uc45lCwCnaK4sluSWyQCN+neR0ApDlKsrojsIQCh96nVIM4Gt566RbvPPgelQA2Kz3mdetDoDKOpaF4ZsrTCsH1m0Hi+w4IFxl6+M0iBbZj275ixYBoK8pDSw3ky/EyZk5cWo9LIeH0SyqOFMWr/zqrQs8UvEQJiJjkR1FsmVEZVG7Fx0/+AYh6NWuu35DIcXPmjnv4CWDHzENaMaJfOR/Ikh/7ofg0ZdAbDpEp+5V+PtzGEQ5x/Mniby87v/hSxMQBESWF8yet7qPOmBGkylRSl5gfxKCOf72dTkhJtStHBcDrGJPUSefd6Z/qBuSqRrMYYhS/s/OqMhJ+3oVeQwYtKjG2T+4d+kb+YFI7I4ngkX+u7sjXa2358CmUGT4pim638InBINwEoBH1RXdYsXbIKzTnl/RzAwZ4tLCjfukH2P2vWgLwkvhBgf9WLfT3w6gqG8pUa75TKBDf4XETWMA0qm8RY/gOF5+4nbdf21d3xyBycAhJQ0oFC/r839pnibMuvwJTeS9GdS7WZq5VRZzrps/RrKrhy+mtvxDi1Ov6EbxWrxK5/OJNEEh653JmnE6F16+dJYniMy4slhVft1f0PiLTyXrfeIjkw2twzJbj96vtkU2NRb1eBcgedqra2kJHYt8wq6PQIMwHGTA50z3a+bl6ernmdeFOEH/qafjfSsZYWZXUozHdTTHzdWL1KF/pUeKxfBlw7sSGZzF1lF/cziyLt/Qh0pnTucXlX8yI/Ic1xJBSf2qZBeod4lHMAUOfO1c9+vOKjZyBJbcZwwvBdQAf9+42hn+mq1dt0HG2Um/KGmeaKZKeE7XT0KqKHdofdjTzHm1QC3Yo9BROGwY5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(83380400001)(5660300002)(478600001)(26005)(53546011)(6506007)(7696005)(186003)(966005)(33656002)(41300700001)(9686003)(71200400001)(66446008)(66946007)(66476007)(76116006)(86362001)(66556008)(4326008)(38100700002)(122000001)(2906002)(8676002)(316002)(54906003)(82960400001)(55016003)(64756008)(786003)(110136005)(52536014)(8936002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmZzRCtrYzBQZndkSlk4Q1c5aFVxejJRQ2xRb0lqdDlIVUorL1JZZnNubk54?=
 =?utf-8?B?Q2dCSWF4c2ZaMGVyL0VNVmJHaWxYczVCVkU0SThjam16YWpmNS9FZWRrTUo5?=
 =?utf-8?B?MnBJU2tJeERwNmc2U2N2VlJtQU5iSUJ0MG92d1A4WFRMR2hmSjdFbnN2aDFK?=
 =?utf-8?B?M1ZKZGJ0WGxlaUhkSi8wQ1VjOUxDTkkwRndjR1lNVkVXNlNURFZpME40V3pJ?=
 =?utf-8?B?S09GajZMYXQ2YzIyUk1TYXh6TkVhSVVTZEtDcElHaTh6RTM2WlU4NXdGT3Nl?=
 =?utf-8?B?M3FRSnZ3cnk4Yll5YW5PRXVzOWhUUFM2cFlZVTJVd0VuLzA0K1o5YzhzWnBq?=
 =?utf-8?B?YTg2cVFWMjBSV2Fna1g1WS80eDBRejdoQnlEZFRNZCtSVnZFTmlMT0RoRVpv?=
 =?utf-8?B?STB0YWFUdW1mMEhZQnl6aEpKWWgyOGdabVNUSXZDN3hXTVdGTkZyY3pjbDhZ?=
 =?utf-8?B?QXU3K0x6M0ZkQzZlM05oSzU5VitCNEJ4Q0MrRnRYT215T3ViR2ppWS9NekVq?=
 =?utf-8?B?bTVSMEM2eXAwbGZzWHNDSFJqcXA4QTI2eFVnMUhBd2M0V2w5VFRYSEdsbXJF?=
 =?utf-8?B?VGlXUVkwRkhyWHgzdlpON29wVVMwMGJwbytOcHoxN2M3RERQdXRDd1p3ZnY4?=
 =?utf-8?B?cERUL2RkdXBSM1lWQmxOdnZoMDNCRElUS1lDMFU3Vkhia25Na1ZNREtiUVpM?=
 =?utf-8?B?a1hNM0d0cGVSMUh6K0FTZHJqNTZKMkFRSzlIaWxJWFk5S2s5eGx3VmIyVkR2?=
 =?utf-8?B?bEhuME9FelhWK3VWNGpOMnd2SEd5ZTR5cDgyVzU3TG10NGpRS2VtWHBBeWxR?=
 =?utf-8?B?UmVhWmd1dDk1VkQreS9VRC9tUFJNSXFRakw4c3pWcVNZOW4xNk9OSy90OURU?=
 =?utf-8?B?cG91Ylh3S2cvWklLVlIyMEZWV0tjTWxCb0grbXpoNTNOZ0dzeHl5YW1aS091?=
 =?utf-8?B?N2lJdEM2RVVwQ1hja0ZKWG1ocmF3SHJRdWEyeGh2NzIwcHNocEw2aC83cFNx?=
 =?utf-8?B?aU1SRllKQXhiMGo5enY0T3dYaS9XY0lrOXpFMmwzREVhTlVZYXBzTk52dkM1?=
 =?utf-8?B?ckdGc1VkazNYL3hMNEU4RjdDKzhGWVpBN25TWlllWDV2ekxkWmlMKzVRR1dP?=
 =?utf-8?B?YTNGRXZra0hkYWY3eERKaFJwNW5FUGxzUWpzRmxTMkNCZVZTU3BXYTJ4d1cx?=
 =?utf-8?B?RUxCSEJpcTBGM0dUS0FFK1E4VEhBUjhkMDdnNURSRnRuaktKSGl0TmkvZXZM?=
 =?utf-8?B?L1BaajlUb2xVbHdIbEROTVFyNE0zbGMxN3hQRUY1Q0NaaTBuSVAwdFFTS3F2?=
 =?utf-8?B?Nm0vMHNmb3U1alJXc05mOFhWaW9ZU1pEeEV6blY3aGJkVzFFblJDL2owZC9R?=
 =?utf-8?B?SmtiY0ovL3hsdEp0MytzRmZyWkltWHhOWnJrRThsNzZNK2Nsc0tYS01IVjR4?=
 =?utf-8?B?YWVRdE1TWEJoeU5UN3M4NDVreGlnQVpWa05yK1IydkhoUnNRNTNud2pIZkw4?=
 =?utf-8?B?alJWeDlRSlZFMDM3WWR6UWFhVm0yWEZ4cS85Rk5XUmVUeXlVdWh3UmNVc3Jn?=
 =?utf-8?B?UG96c3VEUk5RMktnUVNNKzNUY2VpMzVBNi94UUZVRTJOa05uSk5mM2NKQ3Zr?=
 =?utf-8?B?aE1PTDZNSDZiT1VPME5pbkxIZHBRazRaU00yUlZLRTJDZkZNeVI1czZVRVhE?=
 =?utf-8?B?SjZBQmpCdEdiY2ZrNzZJMVlUOTBJYnNtSGNDK1ZhQ2NzNFJEaWIwMENKODdD?=
 =?utf-8?B?WVQ1a0l6TXRwUS9HVU1tUGlFbmp1a0cyWU1JdnptWVZiYzR0b01tWmtQaHRL?=
 =?utf-8?B?VUFRMVZ3MFhISGRYc0RFRlEvTG5YZTQxbktZT2dpcGwra3VobDU4U2tYYitE?=
 =?utf-8?B?NUhOQzcvLzl1ZDNWV29LcmdManlBSE0xZkNzVE41TlZqUXRCNlpiY1ZIWDhz?=
 =?utf-8?B?Tk5rNXBSWG9vWVYrT3dBNURwZkpIRDNBcjc1bk5aeGJRT3oyaThmRzdneWNR?=
 =?utf-8?B?b0dXczBvUUx4bUlzZXlNcXEzVjNOSlA1TFFDc1pITE1kZUF5VnFXaSttOVNj?=
 =?utf-8?B?SGJ1cU1tRVlGcDgzZU9Hc2tBVkhLWCtsT3ZHdG1kN1QvaTJTeWltdGJkNGxZ?=
 =?utf-8?Q?dYSR8tXbACahkINYo//P936Zm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66274243-61e9-4863-0fee-08da7b8d04d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 11:31:22.7662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezB0uiJZ4Tgdm8z2IISWkYqbcYpv7EoCOPCcu4rHPm+p96DGsoDnxPyx/tBXgwQ3sY5Ahx1uf29/Soo5JUb8QhUqJ6LAEtb2fVQSEUnqRb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110034
X-Proofpoint-GUID: k4l5SXCMlek3QCAX0M4bFAqRG-8NVSUP
X-Proofpoint-ORIG-GUID: k4l5SXCMlek3QCAX0M4bFAqRG-8NVSUP
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110034
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdp
QGdyaW1iZXJnLm1lPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDExLCAyMDIyIDU6MzYgQU0N
Cj4gVG86IFlpIFpoYW5nDQo+IENjOiBsaW51eC1ibG9jazsgb3BlbiBsaXN0Ok5WTSBFWFBSRVNT
IERSSVZFUjsgQ2hhaXRhbnlhIEt1bGthcm5pOyBCZWxhbmdlciwNCj4gTWFydGluDQo+IFN1Ympl
Y3Q6IFJlOiBbYnVnIHJlcG9ydF1bYmlzZWN0ZWRdIGJsa3Rlc3RzIG52bWUvdGNwIG52bWUvMDMw
IGZhaWxlZCBvbg0KPiBsYXRlc3QgbGludXgtYmxvY2svZm9yLW5leHQNCj4gDQo+IA0KPiBbRVhU
RVJOQUwgRU1BSUxdDQo+IA0KPiANCj4gPj4+Pj4+IG52bWUvMDMwIHRyaWdnZXJlZCBzZXZlcmFs
IGVycm9ycyBkdXJpbmcgQ0tJIHRlc3RzIG9uDQo+ID4+Pj4+PiBsaW51eC1ibG9jay9mb3ItbmV4
dCwgcGxzIGhlbHAgY2hlY2sgaXQsIGFuZCBmZWVsIGZyZWUgdG8gbGV0IG1lDQo+ID4+Pj4+PiBr
bm93IGlmIHlvdSBuZWVkIGFueSB0ZXN0L2luZm8sIHRoYW5rcy4NCj4gPj4NCj4gPj4gSGkgQ2hh
aXRhbnlhIGFuZCBZaSwNCj4gPj4NCj4gPj4gVGhpcyBjb21taXQgKHN1Ym1pdHRlZCBsYXN0IEZl
YnJ1YXJ5KSBzaW1wbHkgZXhwb3NlcyB0d28gcmVhZC1vbmx5DQo+ID4+IGF0dHJpYnV0ZXMgdG8g
dGhlIHN5c2ZzLg0KPiA+DQo+ID4gU2VlbXMgaXQgd2FzIG5vdCB0aGUgY3VscHJpdCwgYnV0IG52
bWUvMDMwIGNhbiBwYXNzIGFmdGVyIEkgcmV2ZXJ0DQo+ID4gdGhhdCBjb21taXQgb24gdjUuMTku
DQo+ID4NCj4gPiBIaSBTYWdpDQo+ID4NCj4gPiBJIGRpZCBtb3JlIHRlc3RpbmcgYW5kIGZpbmFs
bHkgZm91bmQgdGhhdCByZXZlcnRpbmcgdGhpcyB1ZGV2IHJ1bGUNCj4gPiBjaGFuZ2UgaW4gbnZt
ZS1jbGkgZml4IHRoZSBudm1lLzAzMCBmYWlsdXJlIGlzc3VlLCAgY291bGQgeW91IGNoZWNrDQo+
ID4gaXQ/DQo+ID4NCj4gPiBjb21taXQgZjg2ZmFhYWEyYTFmZjMxOWJkZTE4OGRjODk4OGJlMWVj
MDU0ZDIzOCAocmVmcy9iaXNlY3QvYmFkKQ0KPiA+IEF1dGhvcjogU2FnaSBHcmltYmVyZyA8c2Fn
aUBncmltYmVyZy5tDQo+ID4gRGF0ZTogICBNb24gSnVuIDI3IDExOjA2OjUwIDIwMjIgKzAzMDAN
Cj4gPg0KPiA+ICAgICAgdWRldjogcmUtcmVhZCB0aGUgZGlzY292ZXJ5IGxvZyBwYWdlIHdoZW4g
YSBkaXNjb3ZlcnkgY29udHJvbGxlcg0KPiA+IHJlY29ubmVjdGVkDQo+ID4NCj4gPiAgICAgIFdo
ZW4gdXNpbmcgcGVyc2lzdGVudCBkaXNjb3ZlcnkgY29udHJvbGxlcnMsIGlmIHRoZSBkaXNjb3Zl
cnkNCj4gPiAgICAgIGNvbnRyb2xsZXIgbG9zZXMgY29ubmVjdGl2aXR5IGFuZCBtYW5hZ2UgdG8g
cmVjb25uZWN0IGFmdGVyIGEgd2hpbGUsDQo+ID4gICAgICB3ZSBuZWVkIHRvIHJldHJpZXZlIGFn
YWluIHRoZSBkaXNjb3ZlcnkgbG9nIHBhZ2UgaW4gb3JkZXIgdG8gbGVhcm4NCj4gPiAgICAgIGFi
b3V0IHBvc3NpYmxlIGNoYW5nZXMgdGhhdCBtYXkgaGF2ZSBvY2N1cnJlZCBkdXJpbmcgdGhpcyB0
aW1lIGFzDQo+ID4gICAgICBkaXNjb3ZlcnkgbG9nIGNoYW5nZSBldmVudHMgd2VyZSBsb3N0Lg0K
PiA+DQo+ID4gICAgICBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJn
Lm1lPg0KPiA+ICAgICAgU2lnbmVkLW9mZi1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNl
LmRlPg0KPiA+ICAgICAgTGluazoNCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIyMDYyNzA4MDY1MC4xDQo+ID4gMDg5MzYtMS0NCj4g
c2FnaUBncmltYmVyZy5tZV9fOyEhTHBLSSFsWUZLZUJxSTBsbXAwQXljU3JaNmtyS3hFTVVOalN3
Q08tdFkNCj4gPiAtRnlNQXU1S0xpZDViQnFZcGZFQkdhUmdmR3RrMWMzSExYVWVrU1NQWHI2cEt3
JCBbbG9yZVsuXWtlcm5lbFsuXW9yZ10NCj4gDQo+IFllcywgdGhpcyBjaGFuZ2UgaXMgcmV2ZXJ0
ZWQgbm93IGZyb20gbnZtZS1jbGkuLi4NCj4gSSdtIHRoaW5raW5nIGhvdyBzaG91bGQgd2Ugc29s
dmUgdGhlIG9yaWdpbmFsIGlzc3VlLCB0aGUgb25seSB3YXkgSSBjYW4gdGhpbmsgb2YNCj4gYXQg
dGhpcyBtb21lbnQgaXMgYSAicmVjb25uZWN0ZWQiIGV2ZW50LiBEb2VzIGFueW9uZSBoYXZlIGFu
IGlkZWEgaG93DQo+IHVzZXJzcGFjZSBjYW4gZG8gdGhlIHJpZ2h0IHRoaW5nIGhlcmUgd2l0aG91
dCBpdD8NCg0KSGkgU2FnaS4gV2UgaGFkIGEgZGlzY3Vzc2lvbiByZWdhcmRpbmcgdGhpcyBiYWNr
IGluIEphbnVhcnkgKG9yIEZlYnJ1YXJ5PykuIA0KDQpJIG5lZWRlZCBzdWNoIGFuIGV2ZW50IG9u
IGEgcmVjb25uZWN0IGZvciBteSBwcm9qZWN0LCBudm1lLXN0YXM6IA0KaHR0cHM6Ly9naXRodWIu
Y29tL2xpbnV4LW52bWUvbnZtZS1zdGFzDQoNClRoaXMgZXZlbnQgd2FzIG5lZWRlZCBzbyB0aGF0
IHRoZSBob3N0IGNvdWxkIHJlLXJlZ2lzdGVyIHdpdGggYSBDREMgb24gYSANCnJlY29ubmVjdCAo
cGVyIFRQODAxMCkuIEF0IHlvdXIgc3VnZ2VzdGlvbiwgSSBhZGRlZCAiTlZNRV9FVkVOVD1jb25u
ZWN0ZWQiIA0KaW4gaG9zdC9jb3JlLmMuIFRoaXMgaGFzIGJlZW4gd29ya2luZyBncmVhdCBmb3Ig
bWUuIE1heWJlIHRoZSB1ZGV2IHJ1bGUNCmNvdWxkIGJlIG1vZGlmaWVkIHRvIGxvb2sgZm9yIHRo
aXMgZXZlbnQuDQoNClJlZ2FyZHMsDQpNYXJ0aW4NCg==
