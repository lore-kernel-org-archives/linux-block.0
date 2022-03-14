Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49505C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 13:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiCNN1g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 09:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCNN1d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 09:27:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0161740938
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 06:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttoi4WpIXAvEfzT/JXC34mcbLY222dGZh4D4P9dy8Jd0aK1b42MIrSOVH+TGufe/MVfQNKaW4mx1Hy2UWn7tx3o3CJV6EQjm3smw+l7w8C92O+L1FM0Jgva+j7O5Kuxnqo2SU+LFpcSicqrgpAtY0T2mJkjQNHpwG/aGO89YZM4nRIV4j8yFr0dskXvQ6YZRhVMm5aiuZlx4pMjfOpan0zv0aARfkFwD4UWNx5Rbnn2s/2x2GxmO/gImBLXs7FN/q7AiMGc6UaMP1RWXRrAyOdXXVaUHwtVC35VfgMIv3TqoX6k7xJJpCNZYCEYUkBxgOjscEn0w1bdGz1a/ydOKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq1KfHpvVNb1tfW8RNLpXFqvHvXyO1H/FVEKdwUb64w=;
 b=Ed/Oc+/YdDgXU42+HLoTrBzrM3XGDvKPN+ZkHXpVtIQlyi4aTl3nfafkdD1J1ACHAJbHy6OqjSkaxuakPPJAVZcv9fUHElx/QbnxPX9auF04LgdKQ+3aHFxbwnVMY73AkSoN1OWN279ZZHBLiqtIE6hY3Mm0A9R1LJ6sbigmjlEv5ETjXNyytSW6kWirxPdol60q6lJtn17VT/PHqKJVbjG/C6KYDanEtXLQOUv/KWlQyqJ/h7bPgmOsA0Uz6RGdQhqLqnLRXQZqcvO/YFVD3hdl3JzwMfdUjtQeCjFVhC3p6XSHkkyzzqnvvzl1IgIUfn4wf7fV4EIP8tBlz32Mmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq1KfHpvVNb1tfW8RNLpXFqvHvXyO1H/FVEKdwUb64w=;
 b=O+hidqSfPPKC5YyrIeMOk/ZSGqLyIoOfCAvg8jlYLyowBzSapw0E/VulpBgspva58EacvQ27wW00Kt92ZTKykTEfI2/R9ee1y2p/y2SxlBnGJlZbH76QZk2PSU8h6zCP2Uq7AqX6foK5RlcSDuPCTxh6MR9GSK352y8VPgOvTQcO+kgKDsp4nFwG6Mh6Zghc2BoxHBy111ByLMf803KTZ0Ov63haOGn8rIWUy+o2CtMAEJqvT66D+nylafFqYC6MM3twZIeT6ZVgisvTrxIlaYLVyp1P37HJj8nFwgan25tQkpdcixcD0va/NRg0/VQWl7NrlZ9Kd++6AFC/fsfG3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM5PR1201MB0202.namprd12.prod.outlook.com (2603:10b6:4:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 13:26:21 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 13:26:21 +0000
Message-ID: <d9121e3c-abe5-fe4d-8088-8339c418c7a8@nvidia.com>
Date:   Mon, 14 Mar 2022 15:26:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] virtio-blk: support polling I/O
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Suwan Kim <suwan.kim027@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, jasowang@redhat.com,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
 <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
 <20220314071222-mutt-send-email-mst@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220314071222-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0047.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2f2b69c-6b99-4df0-2fa4-08da05be3a6d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0202:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02029C24D055C50AF8EA7D21DE0F9@DM5PR1201MB0202.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXmTiTYa7VtIoVC+Xbgvv4ru39VfRDaQljTDngjzSvzdf+9xZ9bukY+PcF/00fk1s2QGJDmr4u4sxgLGxlv6LRcttHDWWmDFgTIkyjjJjRShGgmcgjSx+goCXuqBNSVu1ZYVd8kU29840gp72b7d/zRkHaC74ruPlMA85gwxte385Fl/5l3sLki+seGSb6sFOKfvTTWT9ofAW4i+9Y7SXeHTtZe1JtMd9qlHNl06nwIV9KYWYQXgosVdAl0lUR9x3LVfZcQL3wFEZHMvVSDCje68zKSIHyF4S2A39WbkhPjtio0MbWZZSsdpXChTHOQUf4FbbxF+QaO9RlnPXETaBf/To558wfggMVOOSItzGhR5PvqpKsZSuhzkQ5CTnMRp6sDDVYSYgufiXKqab7CBX9hHYBFkdB+fNLAVfpVIaM49Z0rTBjeRiWWkivVK3VM66vRE5hcpGHxHKbHGcQCiWLwl/fZAtb+CU1WxoLb6soIT3v5ks2v+DXLgAO8vVPfGF043J6LZ67wxqpHrxnthHUjvRrF/ywx1fStF91kvJ3cR9c7vzYW/ksvfr6Hjza19YM/zl+yB/7gbjalrxh2kRTTB67lIctwYRU+wRWL1tKUmTPu3BAAHAMMg/oHeiWxBxnwDDkY27Ztu8vzHwslOf7PWoPFgZipBrf5fHoKygs7soAt0bwbCWFhwlGGR588mKlFR6ih+bpUxJ0wGsrbGh65zeET70RfUnn2b0T1mdlPi7EpKZSqwC7s/yT8/48tg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(186003)(2616005)(86362001)(26005)(38100700002)(31696002)(6916009)(8676002)(2906002)(4326008)(66946007)(66556008)(66476007)(54906003)(316002)(36756003)(31686004)(8936002)(5660300002)(508600001)(53546011)(6666004)(6512007)(6486002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjJzaWZGT2VuSS9pYUxON20yeHhmR2phdWp5Vy9nakNzOFVlSTFFbDFmOHNs?=
 =?utf-8?B?NnNCY2dsSTl5OEhldEJ5dnIzdHFqbkFNVWF6S2tEQXZvYlFPTWdIUTBoMERM?=
 =?utf-8?B?VnhBalZEZnhsRzJ1MzJCUnZkTC9EKzQ1MDJVOElDZG9lZVg3bEMxM1lDQXN6?=
 =?utf-8?B?ZEI2UHN6VXRtM0hsZ2NGQWhsZFU5d0dRK1R0YmlUWXRlUVphR1FkUjRaVUJZ?=
 =?utf-8?B?Y2VNeE5FNVVjRnozV2VOQjJrVGhmUEZuVUd3VVZJenZEWkowUWFwcjBaL0ly?=
 =?utf-8?B?a0IwYkZlTFZpWGRuajJtNVhwNkN4V0JianZWVUVETmxZR2x5MmdYOW1nbzls?=
 =?utf-8?B?QkRqdWRBNGlNMnlFeWtGTEhVOHdQaStFN1ZSUFhWcDBDU1NSNXBhUldqcDBJ?=
 =?utf-8?B?aTlSTGNPcGFsMlhucEZXOGNEYk5aRWpVVlZ3QjFiYkZRRGEyL2dQR0FienE0?=
 =?utf-8?B?MzQybmJHWFVlU3h3dWFtTUJBUnVZZWJHUDVGTCsyZ2taVzg5OXM0NWlIQkxl?=
 =?utf-8?B?U2lJbisrQlozZnJ5NENMb0RpSGc1YlBSL2JCL2RMQVZTUXVQV21Ub1REZ2Vw?=
 =?utf-8?B?dkFYMjUyZkljUnNkVUk3K3BMV1Y1TTJWeVpGWndlNjNKSHg4WjhaMVU2bHR3?=
 =?utf-8?B?NDBoSS9tb1RuSHlQTGt6QXg0S3RDOXE2bTZMR3kyUnd0RWhnWk93VmpjSFBM?=
 =?utf-8?B?R1VVS1g5RUdxQmJCU2RBQ3RXOXBSbWJTdTEvZ25kZmJNY29EazhKWlp1TEpF?=
 =?utf-8?B?aVE3U3IrOUpJYXFYY25vSFlqWUhDL2NJU0FKZm1saXRPbFFiSDZHb281UjEz?=
 =?utf-8?B?ajdrU2R5bXNFVVVNREowUHp5azBEaTFpUHQycnVhNzQyY1JYRER3bnVuOU5N?=
 =?utf-8?B?azhpamEvdERseVZncWRFT2NjNHpRTldCQmovMEJtNnlENUhBRlhoc05tRXV6?=
 =?utf-8?B?Q2hPbEhGSzFHY2lrSldxVTNMRUpXYU5pVzdVMHpqTm9YSm5jeCtlTFRnVnVo?=
 =?utf-8?B?QXFHa0VHN0k3VVRlYS9QV0kzZXlzRG9UOHdjYXpvaWJyWWtMTmFGbGpJZCtY?=
 =?utf-8?B?Z1hTVXBCZWkxcjhJMVV2MWl3c25iditXZkRYdVhDSGYyTGlic01tUXNrbkpp?=
 =?utf-8?B?VmQzZldKMDl6czVsdW5ma0ZqZHk2UlY2OEVMZllZc2xlU2Y4eHNrOCtWbGNR?=
 =?utf-8?B?S1IvZy9CbklHMEcxUDUyL3ZJTVNaMmViOVRtT0owekNxcEQrYU5VcjhlcTZ6?=
 =?utf-8?B?ajhiUzhkRXI5SjVrbjlVSGNwMTZXY2hKb2dxWk9TaWNuMWdHbmcrYTVzZWg3?=
 =?utf-8?B?c0lBZWhnVXY2RUN1eHRQN1A2TzhpaWZodGdQWHdGWDFMOFBsLzlONnJoRkdI?=
 =?utf-8?B?Zm9GdVJJTUVWN2FTeGVuRU9KVkNlbmU2ZExCdnZFcXExSmliU3NrSitFNWF4?=
 =?utf-8?B?blR5ak1na2s5TndscE1ITE0wTmkzbTlCU1JSbXNTTXozQzd5RTkwcThZWGhL?=
 =?utf-8?B?OXB6NW5ocHlKRjBJTXBTbFp3WHprWVJyMkY0STllQm1wVnl4c1BiM0NYdGhy?=
 =?utf-8?B?dk5nYUlJaGlLajF4WnBvaVBRZVJzRk5tWVNJMS9MUnlUTlI5aXVKMUVOS1lJ?=
 =?utf-8?B?M2Y0c1huanZqQjBWZnhmSUwvWnlNSHprWEJGRisvU2VraUlrenRxYzUyQmo1?=
 =?utf-8?B?WUJNbEEwRkFlVnRaaEhLT1p0RzN3enAySWZFbHZGMnUvVmRJR0xQUmxBNy9l?=
 =?utf-8?B?anRWTHFTMnRDakNKeWJkZCtteEdaQjc2dW9naDh2U3ZaYnMwQ1liVUZlL3pw?=
 =?utf-8?B?S1ptLzh6RWpJL2FCR0liY2xCUnNZUCtNanVjbks5Sk5XdmU4TVpQZnM5aXB1?=
 =?utf-8?B?RldyNUg1TGFSTkxqY3pUR054QllLMHBnQ1RMT3N2dG95dEY2Rm1FTkNiSlBD?=
 =?utf-8?B?OUFPanZqYTBlMHZlYi9PbWFleGMrYWt6eVFzSG9SN3VnQXVpSnBPZlFTY0ts?=
 =?utf-8?B?TDRlL1FEQjZnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f2b69c-6b99-4df0-2fa4-08da05be3a6d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 13:26:21.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFjdQwA0jWkp13UMQARH6xb9i60Nx0QVqUIf0IOoN0RcIu+/3s0+j2BQJfQWKXEdbCxIiJS5AxBxNbotwv0Ysw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0202
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/14/2022 1:15 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 14, 2022 at 12:25:08PM +0200, Max Gurtovoy wrote:
>> On 3/14/2022 11:43 AM, Suwan Kim wrote:
>>> On Sun, Mar 13, 2022 at 12:37:21PM +0200, Max Gurtovoy wrote:
>>>> On 3/11/2022 6:07 PM, Suwan Kim wrote:
>>>>> On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
>>>>>> On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
>>>>>>> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
>>>>>>> index d888f013d9ff..3fcaf937afe1 100644
>>>>>>> --- a/include/uapi/linux/virtio_blk.h
>>>>>>> +++ b/include/uapi/linux/virtio_blk.h
>>>>>>> @@ -119,8 +119,9 @@ struct virtio_blk_config {
>>>>>>>     	 * deallocation of one or more of the sectors.
>>>>>>>     	 */
>>>>>>>     	__u8 write_zeroes_may_unmap;
>>>>>>> +	__u8 unused1;
>>>>>>> -	__u8 unused1[3];
>>>>>>> +	__virtio16 num_poll_queues;
>>>>>>>     } __attribute__((packed));
>>>>>> Same as any virtio UAPI change, this has to go through the virtio TC.
>>>>>> In particular I don't think gating a new config field on
>>>>>> an existing feature flag is a good idea.
>>>>> Did you mean that the polling should be based on a new feature like
>>>>> "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
>>>>> and features[]? If then, I will add the new feture flag and resend it.
>>>> Isn't there a way in the SPEC today to create a queue without interrupt
>>>> vector ?
>>> It seems that it is not possible to create a queue without interrupt
>>> vector. If it is possible, we can expect more polling improvement.
> Yes, it's possible:
>
> Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
> \field{config_msix_vector}/\field{queue_msix_vector} maps interrupts triggered
> by the configuration change/selected queue events respectively to
> the corresponding MSI-X vector. To disable interrupts for an
> event type, the driver unmaps this event by writing a special NO_VECTOR
> value:
>
> \begin{lstlisting}
> /* Vector value used to disable MSI for queue */
> #define VIRTIO_MSI_NO_VECTOR            0xffff
> \end{lstlisting}
>
>
>
>> MST/Jason/Stefan,
>>
>> can you confirm that please ?
>>
>> what does VIRTQ_AVAIL_F_NO_INTERRUPT supposed to do ?
> This is a hint to the device not to send interrupts.

Why do you need a hint if the driver implicitly wrote 0xffff to disable 
MSI for a virtqueue ?


>
>>> Regards,
>>> Suwan Kim
