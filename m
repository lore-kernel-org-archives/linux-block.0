Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA5AC433ED
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 06:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C658C6113C
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 06:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhDSGL3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 02:11:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60490 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhDSGL3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 02:11:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13J69QIj013276;
        Mon, 19 Apr 2021 06:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hpu8Nu3lC3rCcdsDDDbnowKIgXslumtsKEuXEd7r27Q=;
 b=zbYDXsAM+Ps2Xgf2dznlUYi6BI8hguZ8ScmT+o0spbiVgw5jinSH3Kz8Ha4SDcfzzXSO
 aAi8KAqwJosbh12dWvtixuSPGVBHdFGNv26IDLnHg+Uk24bXqlMIMhjglzbTPTJ5H9Ji
 l8+cpVnuYTZRHVoRzJkLhqU2yCCjDpmpQyHeW7T9tE8HXR54RMBVDTOYNmhtgDPRtCU3
 9SdSxGCIbOjWJpevnWClZsXVow96Fr+fqKJT7fw9tiGkfUPB1q+9wU91g7otyYveBr80
 whZGFrV6sZwTK6MZ/i69A9CHziIhKf7QLkgvJKkJg4mYrSbpYvgWRZ3k+U0+HRrN01h/ +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 38022xsq76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 06:10:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13J6ApJe051505;
        Mon, 19 Apr 2021 06:10:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3030.oracle.com with ESMTP id 38098n6c0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 06:10:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1TOdXClMiQBkLHVCf5xDSEa+sa1/Pq4F0Fk86TFEH2sGTbe5aJa0Okfl0gAmLTNb3cO/298PeZkt4nRpdAI/ejacfPaIFjAJ62F9fL7sQVwtrZRy/3TFt79lRslD95DZ+fH/tAR95azS+ierAxvUa3izQyMlnH60SbN5y6Yo4th0fqyy75qYiuBxvTLvd0Vn1QKmlPMpo/iinqzHYjK36mWAhY4j9wQFlWvhYd0M0Hdwhj81z+aLP5DCYcPYGTfF8ZpOOP+b7x8MqdJuV6zPiUyuxzgY8c1Aal5yH+5WKgLofPHb4jY9S2Q3I2gde2MyA2xD1mQDzZuTRhL0MTuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpu8Nu3lC3rCcdsDDDbnowKIgXslumtsKEuXEd7r27Q=;
 b=TIChnrfp5Xkuck0EBAz58wg8X3RV+jZxDqIT12/9AjHQ3rx4NJVQLwlyUQ3upw5qSsEmZW21LAaXthQLYR0k0JGKMqfHsUkejIZw4Mohv3m0BZGeftUK1NYi7eE7u5voP/O/qnk21dxZXzqqoGW7m2F53uwr2TNm9TMHPg43huJnBG00v+vQD5mrwd+27PldhXKTjgBg9uidZue3ae+EBIm9OD7AYoi8XUYNb1zQv6L3P5pfdUPwitb9p1LOcNiD3e+3vSNq0CLz+dQgy3aHeuStIyPonTxRqPZyCo/36aMRfyo2FBtNOToDDQf0Kof1OCsw2Wb+6QX35ESZevqtgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpu8Nu3lC3rCcdsDDDbnowKIgXslumtsKEuXEd7r27Q=;
 b=B6zNqPDdJzCME5QHXDHkOK8KI/b26/C8yw42p8qvISgLy+TT5E/53/+wn8bQ52zCqCR9vGvGzlmow4H2pqdUozyjDPAd4YfLPdN5iqHTlth5ZLE23yyasqOyjIM1+tP2c8kdlCIox2RRvTkkuQGTmMqLqKq3H8xfgjW/CfX52OA=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 06:10:35 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::7865:7d35:9cee:363f%5]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 06:10:35 +0000
Subject: Re: [PATCH] block: fix io hung by block throttle
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk
References: <20210414211830.5720-1-junxiao.bi@oracle.com>
 <20210417101008.4132-1-hdanton@sina.com>
 <20210418123342.13740-1-hdanton@sina.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <1c3a2874-35bd-3ff0-3088-1a6ea968d016@oracle.com>
Date:   Sun, 18 Apr 2021 23:09:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <20210418123342.13740-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SN2PR01CA0039.prod.exchangelabs.com (2603:10b6:804:2::49)
 To SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-232-116.vpn.oracle.com (73.231.9.254) by SN2PR01CA0039.prod.exchangelabs.com (2603:10b6:804:2::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 06:10:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cc43097-7a6f-4ba2-1811-08d902f9d8c9
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4718:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47187BFA207FF410E0A47B85E8499@SJ0PR10MB4718.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brasM7R0oXNqj53NaI4zDHUOHlv4CWFQOG/S6HMCUROcSPgWj1r/e1V0I6rc21sikdTNvhUwKmPVGbagD3ProToJ95xBJ4gIf0pjIuZjc/JZcl1PdOYoMm1ppv35U2/cSJhpZFDjLWvibgZqlHQCVsEvxFTzpikC0kQtVpTpsfw23yFIPitLMUajCiM534iq34glB7TGNnZMySCaOCLigAnS8Ds+Z2vDwg7Z/vuJ/Rn7CiuC6vALmdHLpTnnZTgycjAl0KpAFUgCNY2ZDkJgqW954s20XvJ1iALpFRmTIZZfDOI8uw3db9AKCt4GSw5rYUntmdE3XBIH3FWKmyg08L2yp6EoVTq649/JGOCs69ZHl7i1Sa/n55tjISFrNSxL8iIevTGYjwDSEulsPmuLX+MzHXUJWUU4SLhVtJ0X1PycQa17r13gFBQMKAhqt7QdSybxkMsQb6+u78SAiLPg5s/ll15AQ42ZqocDSUoEJu9q8odEd/YEqwVgTLxPLOeym9VamO6mlGLPM72V02m3QsFxcOIovgJSACsFX2drx2RUr0ChWm2IiNSyB5lYrw1VGeaBdYVdOHbNGpl38UHUti0VMcHJAobMDelQaN7wbXPRFL1Ddt+JjZQtD7C+da+6DEBdhvq7qg0Jzvk9QaGF2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(6486002)(2906002)(44832011)(7696005)(8676002)(5660300002)(4326008)(6666004)(31686004)(38100700002)(53546011)(66476007)(478600001)(36756003)(16526019)(31696002)(186003)(6916009)(956004)(2616005)(66946007)(8936002)(316002)(83380400001)(66556008)(26005)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SWRKNTdSYnU1WmYrcVVzdGRLR05QZ3Fkd083UnRUKytvZ0NBK2JqSFFSbWRV?=
 =?utf-8?B?NjBYSjdoNkNvTEk2aXErelV2UzVEZm8xSk9idUJ5aXlqRy9TN1cxNmJDTUxt?=
 =?utf-8?B?S0JOeGxra3hrQ2hMMGhNS0dWVEo2MzRQQmdWRVpIOTM4OGo0dE9OVXdzQWF2?=
 =?utf-8?B?MEppTlp6YVorb3l4VVBneDNpVUNKVjRQa3VYTjBZV215ZTZwcDVMK2EyZTB5?=
 =?utf-8?B?cy85Wi9kLzkzcE1aM0VHZnJyeitNR1dRV1ViQm9YaGtISUhXZk8wUFFIeC9L?=
 =?utf-8?B?Rkp5YTZBMVlXU3cwdjFPV1RrcjZzQkdsUHNEQVBqcVk2bkh4RnVsUmdUM3dL?=
 =?utf-8?B?RXViREZTVFdWQklFbWp5MVE4eFVDZlcyK1VhOGVPTlJWMVZtQWprRVFscFMz?=
 =?utf-8?B?ZEVmRVMxdHhraVA3b1RLRGRBdWV2TXNhQWdKYTk3TElxalBqWWkwNmRka1VN?=
 =?utf-8?B?TWJRR1dXemtMWkMzcVA1dWZEVFMrYnRHaUI1VWY3K1JtWXFyTXhiUHgyamhi?=
 =?utf-8?B?aTZiTFFpYWRuanVTVmtMSTRHM0s5NXg0VlNieE9mQi96VG9taFVxNzl5NDVi?=
 =?utf-8?B?dTlKMG0xaXpId0hrR0d1L0V0c0FtVVV6RXRybzRCOVJUb0hvSkpVd3ZycGxM?=
 =?utf-8?B?alVwMWtZRnFqNmRXVTk3a3RCMk1laytLYnhTb1pJdzNCa1M2aHlrbzAwenA3?=
 =?utf-8?B?bHNIN2FET1RvUXM1cE41WkpGdzdTc1hodEk5YWRJbG1YQlBlU3BCWXk5MzJC?=
 =?utf-8?B?TFN5ZmlmNEJKMG9xOVBVSW5rdUZwZ0h4WVpiUEVBc1ZUTEpUZWtLN3FGWStI?=
 =?utf-8?B?aVlrZ3MzRUFTNnNIbVQ1T3dDTkpCVTlrU1Ixc1I0NWtQaWhOWjdFR2pIT0dQ?=
 =?utf-8?B?cURjV0M4VUh2MGJtRVMxazlUZVhNajNEbjE1bU80bENDYlR2TXp6cXRoM2dJ?=
 =?utf-8?B?VHBCMlBYSUtQM05kMmFHcnQrejRDOTY1TE9DQ2x0cmgrbDA4VVROMHV3QzZI?=
 =?utf-8?B?akFCMmdVWWlIUC93ZzA3T2JxK0ROSXNJU1BqYTNoaEFOMk5NalhiVHJEd3ZQ?=
 =?utf-8?B?dzRLZ1BZNDIvdFU1Y1pBVXEwNUdHTmp4ZlVjOEM4L1hQL0tmclUwNThTUWMy?=
 =?utf-8?B?N3FtZXdEalA0MWhmK3pKU3ZpVE41RGZWWFZzMkhaTmJMY2JjYnM1cngxZGc2?=
 =?utf-8?B?SzRTMHNpeVVodktyTFAyUjNuSzFsVGNjZG16dDBzQXNlK040Y05pV3JvSHhu?=
 =?utf-8?B?U2tYK3YwVjgrMTB2amRkdUc2Rm1UKzZORUhvWFJTYTJHZ1E3eVhDNDlmSXMw?=
 =?utf-8?B?Rlc0NzQrMGYzTjVIbm1SU3pOSExtTzh6bW9yZjh1MzhSRGtnb2FBVk9HTnZ4?=
 =?utf-8?B?Vy9VY2lXcHRKMzU0V0ZHZFhvMVhQeXQ2cFdwWHB6cVZaTllWVlZPQ0Z5TWlz?=
 =?utf-8?B?RlgwcGxyOGY5SHhGcml2Ym0yMkVpVUNrVGNLQWZhVndVazdSRnhENjZtUmtM?=
 =?utf-8?B?QjdCaDcwdXFMRkgxVXYvcDR5NmI5WVh0ZXI1UmZpeENRcHFpN2ZCTi93MFY2?=
 =?utf-8?B?WEdLRXZockdhN2pvbkNjTSs0NXNxSE03OWRmeHU2Mmhmdm5ubmZzQTZwQjlT?=
 =?utf-8?B?K0VucGtGSFEwY0FuSDVHeXpIWUs5WlV6dThpTlhkaUplTCtBaWd5ZlNXUVd0?=
 =?utf-8?B?S1NhZnh1b1VOQ2pkTXVsRGNBbVpua05wK2lLSEhXU1ZTd2hQd3UraWo1dSsx?=
 =?utf-8?Q?dF25dEu2/XvRJ7VTLrTl2lRvQUrKj7htB9GfHMG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc43097-7a6f-4ba2-1811-08d902f9d8c9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 06:10:35.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpIhFSMdESNaDbhjBmq/Uc3pBzrwSUuEBA473PExVCbyHz1bHueCdybns4OmPXAB7eBSrEWh1NIQ6Gw7wat6Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4718
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9958 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190042
X-Proofpoint-ORIG-GUID: z7wNxrhPkwYN3YnE0o2YV9lhDephtDyb
X-Proofpoint-GUID: z7wNxrhPkwYN3YnE0o2YV9lhDephtDyb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9958 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190042
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/18/21 5:33 AM, Hillf Danton wrote:
> On Sat, 17 Apr 2021 14:37:57  Junxiao Bi  wrote:
>> On 4/17/21 3:10 AM, Hillf Danton wrote:
>>> +	if (acquire_inflight_cb(rqw, private_data))
>> This function is to increase atomic variable rq_wait->inflight.
> You are right.
>
>> What's the mutex for?
> It cuts the race between we peek at the sleepers on rqw->wait while they are
> coming and going, and we cant update rqw->inflight without making sure there
> are no sleepers.

Why? I think checking the sleeper in original code is for a fast path.

For wbt, acquire_inflight_cb is wbt_inflight_cb where atomic_inc_below 
is used to update rqw->inflight. I don't see why a mutex is needed for 
this atomic operation.

>
> With the mutex in place, in addition to the certainty of !sleepers, we can
> avoid the race between us and waker in terms of updating inflight by removing
> the invokation of acquire_inflight_cb in the wakeup callback, and the bonus is
> we no longer need the wakeup cb and the rq_qos_wait_data because the more
> traditional wait_event() can do the job.
>
> Finally we can dump the cleanup_cb_t.
>
> +++ b/block/blk-rq-qos.c
> @@ -200,96 +200,24 @@ bool rq_depth_scale_down(struct rq_depth
>   	return true;
>   }
>   
> -struct rq_qos_wait_data {
> -	struct wait_queue_entry wq;
> -	struct task_struct *task;
> -	struct rq_wait *rqw;
> -	acquire_inflight_cb_t *cb;
> -	void *private_data;
> -	bool got_token;
> -};
> -
> -static int rq_qos_wake_function(struct wait_queue_entry *curr,
> -				unsigned int mode, int wake_flags, void *key)
> -{
> -	struct rq_qos_wait_data *data = container_of(curr,
> -						     struct rq_qos_wait_data,
> -						     wq);
> -
> -	/*
> -	 * If we fail to get a budget, return -1 to interrupt the wake up loop
> -	 * in __wake_up_common.
> -	 */
> -	if (!data->cb(data->rqw, data->private_data))
> -		return -1;
> -
> -	data->got_token = true;
> -	smp_wmb();
> -	list_del_init(&curr->entry);
> -	wake_up_process(data->task);
> -	return 1;
> -}
> -
>   /**
>    * rq_qos_wait - throttle on a rqw if we need to
>    * @rqw: rqw to throttle on
>    * @private_data: caller provided specific data
>    * @acquire_inflight_cb: inc the rqw->inflight counter if we can
> - * @cleanup_cb: the callback to cleanup in case we race with a waker
>    *
>    * This provides a uniform place for the rq_qos users to do their throttling.
>    * Since you can end up with a lot of things sleeping at once, this manages the
>    * waking up based on the resources available.  The acquire_inflight_cb should
>    * inc the rqw->inflight if we have the ability to do so, or return false if not
>    * and then we will sleep until the room becomes available.
> - *
> - * cleanup_cb is in case that we race with a waker and need to cleanup the
> - * inflight count accordingly.
>    */
>   void rq_qos_wait(struct rq_wait *rqw, void *private_data,
> -		 acquire_inflight_cb_t *acquire_inflight_cb,
> -		 cleanup_cb_t *cleanup_cb)
> +		 acquire_inflight_cb_t *acquire_inflight_cb)
>   {
> -	struct rq_qos_wait_data data = {
> -		.wq = {
> -			.func	= rq_qos_wake_function,
> -			.entry	= LIST_HEAD_INIT(data.wq.entry),
> -		},
> -		.task = current,
> -		.rqw = rqw,
> -		.cb = acquire_inflight_cb,
> -		.private_data = private_data,
> -	};
> -	bool has_sleeper;
> -
> -	has_sleeper = wq_has_sleeper(&rqw->wait);
> -	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
> -		return;
> -
> -	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
> -	has_sleeper = !wq_has_single_sleeper(&rqw->wait);
> -	do {
> -		/* The memory barrier in set_task_state saves us here. */
> -		if (data.got_token)
> -			break;
> -		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
> -			finish_wait(&rqw->wait, &data.wq);
> -
> -			/*
> -			 * We raced with wbt_wake_function() getting a token,
> -			 * which means we now have two. Put our local token
> -			 * and wake anyone else potentially waiting for one.
> -			 */
> -			smp_rmb();
> -			if (data.got_token)
> -				cleanup_cb(rqw, private_data);
> -			break;
> -		}
> -		io_schedule();
> -		has_sleeper = true;
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -	} while (1);
> -	finish_wait(&rqw->wait, &data.wq);
> +	mutex_lock(&rqw->throttle_mutex);
> +	wait_event(rqw->wait, acquire_inflight_cb(rqw, private_data));
> +	mutex_unlock(&rqw->throttle_mutex);

This will break the throttle? There is a inflight io limitation. With 
this change, there can be only one io inflight whatever the limit is.

Thanks,

Junxiao.

>   }
>   
>   void rq_qos_exit(struct request_queue *q)
