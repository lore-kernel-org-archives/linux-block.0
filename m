Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D20EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 10:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjF1KFr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 06:05:47 -0400
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:22465
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231304AbjF1JwO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 05:52:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MU/rz0sV3SOvMHNUtsxIiAyOJeuw8Ttu5nYduRu8sEfRYJ6NALgY5cni1IekaQSsKQPiT8mWaSSZDcwLNXFuvt/fP4xbKABdDaMhz6I3it9VGKAm9heZsY8TbrymUBauHJWi34lLVclbgM89ZgKnYo2liCvewcJCZ9pyMr19z+QXhW9bhDlWwWfQ6F+6mydzMT3OET3+DzhsoH9o0PQafkkZcMJBOfnyTxZYueleV6q39nMxo5vcg/N0Uz+mRTq+2wZnm6yZ5i4TARFJ/jk41p2ueO77OXPLgi9yT3vozBskwvq1Fq3+QsrLNM04vwQ9uooDEccruLW1z6zUCN1xig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tgnhAxT8L8SSL5qf6wLxIxiNOvrMQFtSpCYumf+6hw=;
 b=GbLBKR1FSk8LJvPfoMewXiX8xmYKVrXBeUgDY9laVBe7ncD5iw4ICD7L9VtI9NjVNYWFj6y274AGOeUp6bzCUGyF3Uid6yG/HUmAsKOIbF1HDDwF6OMjWRJHm3m42GQT2YHpGGYHGIhJ+Orz4XHVFTiq2LEC3EeZJfDUdPXtWHWCZwHyl7fIpO1KffV00ayvcxRLpv/K+skMwjg6Kq3hem8eQ0tpt3A4d6yXxCz7xUVthMkCEBoHmDVUh3563L0XEcliQsiHP11zzj4g+rQp7GXKuRIZSBCZ66hDkwCSsEex47jxZF4odNTjlD2qMuC8v8p4lBsZdXfcX9NEA/kfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tgnhAxT8L8SSL5qf6wLxIxiNOvrMQFtSpCYumf+6hw=;
 b=Kbqd4Y+Fi31KbgQeiC9zJd7oSK5HWuWHZGtttbXP9kLHL/+Ylr34r9uM2ULtIBPFlh1IEa32S9PVR3w2Hvc7JeO1lncqwTirW4Zc5iO8ctUKy/DsBdDjycyMVKkFhaaY5WWpsYHKRvJvr23aefuKNYDm9Oln89VpbKwouNbVTZBC0faOpXX2EHqzm0kTaOS6MAJ7mjcH4wu4A2GBEOrP8QtHjSJCAM/Vos4xC8i+G2Qqojr9AeWNNvHV2orMep4nbydG+d5jpVwxotwDTK6mpRauDnCIUKI0nGJoXoOnhvbPmD4TjSI4PgCr78jfAOVRW1PFomvQKOuLQS8UYcVgtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 09:52:11 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 09:52:11 +0000
Message-ID: <94785130-4f40-aa29-9232-af8a8f1ca1c9@nvidia.com>
Date:   Wed, 28 Jun 2023 12:52:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
 <000e3d0c-0022-c199-1f8d-97e191345197@grimberg.me>
 <d5d9bd87-1d5b-d66c-39c4-e35c0e5ddc48@nvidia.com>
In-Reply-To: <d5d9bd87-1d5b-d66c-39c4-e35c0e5ddc48@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f685f3-5fcf-45fd-43fb-08db77bd582d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnQ3LqQUGFDh43/X9aV9n4jx9q7/Acz6nmIq6XAhFsd6LP29wBgvVvT9KxZ8vItwg6OMJAythi/2nIxkQT3DaoYMT6IhVcqLBxKpXil91Q0bUuR3Hd3rFHdIyN7xhpx+pI8iRcGZl432kWhjuKhsBShTDFeqP4wedms7YFGcdltRa7G/VD984kR/zH0MXagHs8U/Qh9QWNidbU9tjqnhUoFu4LMFtjgzZ7SXuK1+UBvExvYeMKzoWQGbueA86omUkFdjlM+COI5cJLzQrn2rZAvG8g/V7GIHh/ImKT+jWI4Q/tJ9r+3RofEvtG1nCq0ThUDjUhLQY9NlNnv8sM98miqo6Gn8IrYonSliK71xqILhPQLY7LbicDe8RDIW0vTkE7zYGoX1PPuJze9lAgiKtLfJvgn9m21mbfzDhmUQ4P2MSaFV4iATM0Noim2K+R2kkC1ir8B8UGeQ6yHc15nh6uyTuGTMOMeTGSIk7PN3xUMZqyaVUXeoLa0XMmUs5fx8nJ/77bAsWvwvcOBdD7MVye+eiLhOXbnrbH42f6kKDQg+hrUUdyNIZL6CG4n31YbYPVeEtguL3QQoGfWnNgMfKwQqJstCLCNm84TiG8gIniOdJ055yGBLS4+fmyX7r/Tb53V2z6MRemIskLRaeleAHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(31686004)(53546011)(36756003)(5660300002)(86362001)(8936002)(66556008)(8676002)(41300700001)(66476007)(316002)(4326008)(31696002)(38100700002)(66946007)(2906002)(26005)(478600001)(6506007)(186003)(2616005)(6512007)(110136005)(83380400001)(6486002)(54906003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTBERklzQnRyYkNLNEE0SFhHU2s3djRUaE5EYXJQMFhheW5MRmpvT095OHpS?=
 =?utf-8?B?RWdtdmdlY0FvOTVPSEczcm5EdDIxRExWaVNmQmREcTJ2RHUxeWpOeGpWcUVi?=
 =?utf-8?B?N2tBQWY5V3R5VW4rWkQrQzlMREVmYkNvQ0FLZzdMNjlkd05HOHlFT1ZpN2JR?=
 =?utf-8?B?bThGU3RIWXJLc0Z6ZHlvbmNoek45MjZ3UjRmaWpEaEhsK3lkdW9RSkoxUm4y?=
 =?utf-8?B?a0JuenNkODBFYm92UldlRURyOVk0M2dxeElYNG5DczNNQmd3cis4RFdZRnEy?=
 =?utf-8?B?Q29QczB6R2p2S1dUMk9OYlJ5TnFYeS9IeFFPYUNTcXd0SFpvejh2Q2tVOU0w?=
 =?utf-8?B?STd4TXNNWFNhc3lxSnluQ0JXREdJRXZERlF1OHhJVW1tSEtpTXZjckNKUndF?=
 =?utf-8?B?aXBOam9LSUtDSzVRMEJNOUZ4aHU5Y0FZa3piRk1NL2ZEN29ySms5ZmoyT2F0?=
 =?utf-8?B?R3R1a3BubHcwR21nckxsR3UwK2NRM0QxeWRkeUxXdjZST1MrK25nOU9FR3B0?=
 =?utf-8?B?L21ubDZUN2RlSmVmZ2pGdElMem9Ya2c0Qnk1MEVaQlA2VGRYSDVRRUp0TFlQ?=
 =?utf-8?B?d3E4aUZKOEtwZmlTNGJDUTQ2WTBESC9CbVNPL3RRZmU4WWRBYytRTEN3V2ls?=
 =?utf-8?B?aEN6Unh5eWY1NFU3a1JPcXk1ZGcvSEVIR3JMV2QrR2F2Sjl4dUJOZ21RYjI2?=
 =?utf-8?B?RmdBck4wY1dRcVVNc3ZLdFNma01RV01zakZSNnJOcS9HYnFXa1E0dEJnaXNV?=
 =?utf-8?B?cHlyRG0zUjVOSnhVK1p0SzJCajA3b3BpRHE5Y2lhYjlyZkI3aW9mbDVQY21j?=
 =?utf-8?B?b1FPTUtGc0I5dnlMNm9Fem9ja2w0WDhtU2NzaDIwYXViSTB4SkFnWXlhbndE?=
 =?utf-8?B?OUx4SmRCRU96WE5MZWM0S1B5bGZGUnRXcWFFY2Z2Q1pjZ2p4cjA5YjBSeWlE?=
 =?utf-8?B?MFc5NlMxdTR4dXVJTDdFaUdPMzJkRWFzaXQ5bjUvVExVRCtkcENlaGhDOGw0?=
 =?utf-8?B?MHNINzIzeEE3L1dteUlnTytZeGJ3YmRWVFVxWHh0UDRhbkc2SWVzQ0hGSm9H?=
 =?utf-8?B?Zmk1Z2pYODlFVFg4K1pWKzAvaUI1bUliVm9JRUNxODdFS2dqWWFpQURUR3pV?=
 =?utf-8?B?NnpVN2xoU3JYdStHcE42RWFHZXBabTNOajk1WlZDeGg5dWZmc3lObno3akZ0?=
 =?utf-8?B?VU1iaTVPSW5HdzBvTkFPMkJrRE5TV0RTK1BPY1J4eXpha0swbGQvK1Q2MXN1?=
 =?utf-8?B?WjEzQnVjSzVNN2Y5SVlkbHdYZkJqWWJVMXBiNjB3cWc4c3g2UHFObEF5MHRW?=
 =?utf-8?B?SDY1Vi9CdkV1U3pDZThhSHJNNysweEg5VVIrUFM2SXA4NGNHSEpuZTJtT2R6?=
 =?utf-8?B?VkhCVHZPZVVzc1RGWGIzOVpsY1lqRDYyYmpXU2hJWkhQRjJOWEZwSXdjMEtJ?=
 =?utf-8?B?a1Q5NDlPSVVuZjFWaHVXUS94cTJnQXUrbFQyNlo2VnBjMWhERWhQUlBaUml5?=
 =?utf-8?B?SnRyRW10V3VZQ3RFaW4yaVhNVWptdHRPY3gyMEpMZ0NYNkFJU2JlK1NRNUUr?=
 =?utf-8?B?Qmk2My9hc1JuVVRKanlUS2cyOFB5M0pBSjREUi8rM3RGWktaWFBMQzBITTVR?=
 =?utf-8?B?eDd4NFpDZU1GN0RycEl0SS8zdmNIR3dUNWxFYitUQTZ1SmlzTXVHc2c0c2RS?=
 =?utf-8?B?ZHRvZWpmL2VnYXVqYmFkejZmSUVGS0xkc2t0YmQrNGJ2d0xiQi84SHIxYTN5?=
 =?utf-8?B?c3NTeWYzellwQkZpNTBSNVZxWnk2ZWdoM0x0OS9qaFRTdEZFT0pBOXNONGox?=
 =?utf-8?B?UXBkbTlTZThYbnpXMUFrOWZqT0xLZHlnS0g1L2dWR2VpMzZSVy9LNTZsNEx5?=
 =?utf-8?B?WGJ0TlJtZWdNM0xNNmp2eTJQY0JqNkhOeVBWeDZhcXl2WllsV3ROSTVqbWo3?=
 =?utf-8?B?bExEbFFLSVVxN1lwL1JIeVNabk4ydTJLNUt6SmhtVStEcE1aUnhBL2FZWUtM?=
 =?utf-8?B?QkViT2NNcUsvZHFCZUNnQ3pqQ1h2QnBjZ1lPdUpQb2hLczZjWm1oQnc5eVdW?=
 =?utf-8?B?Y1JBY01LMkx4RWcxdUhEbjZZTzd4RGRCcWFQSWZGaXdrZWdkS2Z0Ny9xRVc0?=
 =?utf-8?B?TUxhTE5DamVtVUJqWFMxWjlCK0hPdkRBMElHZ1pxTWVzOFFjcDM3UXBkYW4v?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f685f3-5fcf-45fd-43fb-08db77bd582d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:52:11.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CZFdjO0HTMowWcoYSnNILyEsOLqwlEyTqFNOefMLfX5CMA3bzfAyVpq3mcYZ9pNw7aqETtX4yPiYoIjsc1yyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Yi,

On 28/06/2023 12:21, Max Gurtovoy wrote:
> 
> 
> On 28/06/2023 11:14, Sagi Grimberg wrote:
>>
>>>>
>>>>>> Yi,
>>>>>>
>>>>>> Do you have hostnqn and hostid files in your /etc/nvme directory?
>>>>>>
>>>>>
>>>>> No, only one discovery.conf there.
>>>>>
>>>>> # ls /etc/nvme/
>>>>> discovery.conf
>>>>
>>>> So the hostid is generated every time if it is not passed.
>>>> We should probably revert the patch and add it back when
>>>> blktests are passing.
>>>
>>> Seems like the patch is doing exactly what it should do - fix wrong 
>>> behavior of users that override hostid.
>>> Can we fix the tests instead ?
>>
>> Right, I got confused between a provided host and the default host...
>>
>> I think we need to add check that /etc/nvme/[hostnqn,hostid] exist
>> in the test cases.
> 
> Right.
> And if one of the files doesn't exist, generate the value.
> 
> Should it go to tests/nvme/rc ?

Can you please try adding the bellow un-tested code to blktests and re-run:

[root@r-arch-stor03 blktests]# git diff
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 191f3e2..88e6fa1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -14,8 +14,23 @@ def_remote_wwnn="0x10001100aa000001"
  def_remote_wwpn="0x20001100aa000001"
  def_local_wwnn="0x10001100aa000002"
  def_local_wwpn="0x20001100aa000002"
-def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
-def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
+
+if [ -f "/etc/nvme/hostid" ]; then
+       def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
+else
+       def_hostid="$(uuidgen)"
+fi
+if [ -z "$def_hostid" ] ; then
+       def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
+fi
+
+if [ -f "/etc/nvme/hostnqn" ]; then
+       def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
+fi
+if [ -z "$def_hostnqn" ] ; then
+       def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
+fi
+
  nvme_trtype=${nvme_trtype:-"loop"}
  nvme_img_size=${nvme_img_size:-"1G"}
  nvme_num_iter=${nvme_num_iter:-"1000"}
